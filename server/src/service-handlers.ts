import { ServerUnaryCall, sendUnaryData, ServerWritableStream } from '@grpc/grpc-js'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'
import { result } from '../proto/heartbeat/result'
import { HeartbeatId } from '../proto/heartbeat/HeartbeatId'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Empty } from '../proto/heartbeat/Empty'
import { HeartbeatList } from '../proto/heartbeat/HeartbeatList'
import { HeartbeatDatabaseService } from './heartbeat-database-service'
import { HeartbeatCount } from '../proto/heartbeat/HeartbeatCount'
import { getHeartbeatSchema } from './schemas/get-heartbeat-schema'
import { SchemaValidator } from './utils/schema-validator'
import { createHeartbeatSchema } from './schemas/create-heartbeat-schema'
import { Logger } from './utils/logger'
import { Socket } from '@supabase/realtime-js'
import { HeartbeatStream } from './heartbeat-stream'
import { IpInfoService } from './ip-info-service'

export class ServiceHandler {

    private databaseService: HeartbeatDatabaseService
    private schemaValidator: SchemaValidator
    private ipInfoService: IpInfoService
    private socket: Socket
    private logger = new Logger('ServiceHandler')
    private streams: HeartbeatStream[] = []

    constructor(databaseService: HeartbeatDatabaseService, schemaValidator: SchemaValidator, ipInfoService: IpInfoService) {
        this.databaseService = databaseService
        this.schemaValidator = schemaValidator
        this.ipInfoService = ipInfoService
        this.connectSocket()
        this.startHeartbeatTableListener()
    }

    public async createHeartbeat(call: ServerUnaryCall<newHeartbeat, result>, callback: sendUnaryData<result>) {
        if (call.request) {
            this.logger.info(`create heartbeat: ${JSON.stringify(call.request, null, 2)}`)
        }

        const schemaValidationErrors = this.schemaValidator.validateJson(createHeartbeatSchema, call.request)
        if (schemaValidationErrors) {
            callback(new Error(`${this.schemaValidator.prettifyJsonSchemaError(schemaValidationErrors)}`), null)
        } else {
            try {
                const ip = this.ipInfoService.extractIp(call.getPeer())
                const success = await this.databaseService.createHeartbeat(call.request, ip)
                if (success) {
                    callback(null, { status: 'OK' })
                } else {
                    callback(new Error(`Unable to create heartbeat: ${call.request}`), null)
                }
            } catch (err) {
                callback(new Error('Unable to create heartbeat: ' + err), null)
            }
        }
    }

    public async listHeartbeats(call: ServerUnaryCall<Empty, HeartbeatList>, callback: sendUnaryData<HeartbeatList>) {
        if (call.request) {
            this.logger.info(`list heartbeats: ${JSON.stringify(call.request, null, 2)}`)
        }
        try {
            const heartbeats = await this.databaseService.getHeartbeats()
            callback(null, { heartbeats: heartbeats })
        } catch (err) {
            callback(new Error('Unable to list heartbeats: ' + err), null)
        }
    }

    public async readHeartbeat(call: ServerUnaryCall<HeartbeatId, Heartbeat>, callback: sendUnaryData<Heartbeat>) {
        if (call.request) {
            this.logger.info(` read heartbeat: ${JSON.stringify(call.request, null, 2)}`)
        }

        const schemaValidationErrors = this.schemaValidator.validateJson(getHeartbeatSchema, call.request)
        if (schemaValidationErrors) {
            callback(new Error(`${this.schemaValidator.prettifyJsonSchemaError(schemaValidationErrors)}`), null)
        } else {
            try {
                const heartbeat = await this.databaseService.getHeartbeat(call.request)
                if (heartbeat) {
                    callback(null, heartbeat)
                } else {
                    callback(new Error(`Heartbeat with ID ${call.request.id} not found`), null)
                }
            } catch (err) {
                callback(new Error(`Unable to read heartbeat with ID ${call.request.id}: ${err}`), null)
            }
        }
    }

    public async streamHeartbeatCount(call: ServerWritableStream<Empty, HeartbeatCount>) {
        if (call.request) {
            this.logger.info(`stream heartbeats: ${JSON.stringify(call.request, null, 2)}`)
        }

        // Send the initial count. The listeners below will only trigger on changes.
        const count = await this.databaseService.countHeartbeats()
        call.write({
            count: count
        })

        const stream = new HeartbeatStream(call)
        this.streams.push(stream)
    }

    private connectSocket() {
        const realtimeURL = process.env.REALTIME_URL || 'http://realtime:4000/socket'
        this.socket = new Socket(realtimeURL)
        this.socket.onOpen(() => this.logger.info('Socket is open'))
        this.socket.onClose(() => this.logger.info('Socket is closed'))
        this.socket.onError((message) => this.logger.error('Socket error: ' + JSON.stringify(message, null, 2)))
        this.socket.connect()
    }

    private startHeartbeatTableListener() {
        const heartbeatTableListener = this.socket.channel('realtime:public:heartbeats')

        heartbeatTableListener.join()
            .receive('ok', () => {
                console.log('Heartbeat TableListener connected')
            })
            .receive('error', (error) => {
                console.log('Error setting up Heartbeat TableListener: ' + error)
            })
            .receive('timeout', (error) => {
                console.log('Timeout when setting up Heartbeat TableListener: ' + error)
            })

        heartbeatTableListener.on('INSERT', async (change) => {
            const count = await this.databaseService.countHeartbeats()

            this.logger.info(`new heartbeat count: ${count}`)

            this.streams.forEach(stream => {
                const didWrite = stream.call.write({
                    count: count
                })

                // If the write failed we interpret that as a disconnected client.
                // We then mark the stream as not active
                if (!didWrite) {
                    this.logger.info(`Canceling stream after failed write to client call`)
                    stream.active = false
                }
            })

            // Remove no longer active streams
            this.streams = this.streams.filter(stream => stream.active)
        })
    }
}