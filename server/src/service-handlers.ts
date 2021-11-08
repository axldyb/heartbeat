import { ServerUnaryCall, sendUnaryData, ServerWritableStream } from '@grpc/grpc-js'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'
import { result } from '../proto/heartbeat/result'
import { HeartbeatId } from '../proto/heartbeat/HeartbeatId'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Empty } from '../proto/heartbeat/Empty'
import { HeartbeatList } from '../proto/heartbeat/HeartbeatList'
import { HeartbeatService } from './heartbeat-service'
import { getHeartbeatSchema } from './schemas/get-heartbeat-schema'
import { SchemaValidator } from './utils/schema-validator'
import { createHeartbeatSchema } from './schemas/create-heartbeat-schema'
import { Logger } from './utils/logger'
import { HeartbeatCount } from '../../client/proto/heartbeat/HeartbeatCount'

export class ServiceHandler {

    private heartbeartService: HeartbeatService
    private schemaValidator: SchemaValidator
    private logger = new Logger('ServiceHandler')

    constructor(heartbeartService: HeartbeatService, schemaValidator: SchemaValidator) {
        this.heartbeartService = heartbeartService
        this.schemaValidator = schemaValidator
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
                const success = await this.heartbeartService.createHeartbeat(call.request)
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
            const heartbeats = await this.heartbeartService.getHeartbeats()
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
                const heartbeat = await this.heartbeartService.getHeartbeat(call.request)
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
        // TODO: Actually stream from database
        const count = await this.heartbeartService.countHeartbeats()
        call.write({
            count: count
        })
    }
}