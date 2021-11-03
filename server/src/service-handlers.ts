import { HeartbeatServiceHandlers } from '../proto/heartbeat/HeartbeatService'
import { ServerUnaryCall, sendUnaryData } from '@grpc/grpc-js'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'
import { result } from '../proto/heartbeat/result'
import { HeartbeatId } from '../proto/heartbeat/HeartbeatId'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Empty } from '../proto/heartbeat/Empty'
import { HeartbeatList } from '../proto/heartbeat/HeartbeatList'
import { DatabaseManager, DatabaseService, Environment } from './database-service'

export class ServiceHandler {

    private database: DatabaseManager

    constructor(database: DatabaseManager) {
        this.database = database
    }

    public async createHeartbeat(call: ServerUnaryCall<newHeartbeat, result>, callback: sendUnaryData<result>) {
        if (call.request) {
            console.log(`(server) create heartbeat: ${JSON.stringify(call.request, null, 2)}`)
        }

        try {
            const success = await this.database.createHeartbeat(call.request)
            if (success) {
                callback(null, { status: 'OK' })
            } else {
                callback(new Error(`Unable to create heartbeat: ${call.request}`), null)
            }
        } catch (err) {
            callback(new Error('Unable to create heartbeat: ' + err), null)
        }
    }

    public async listHeartbeats(call: ServerUnaryCall<Empty, HeartbeatList>, callback: sendUnaryData<HeartbeatList>) {
        if (call.request) {
            console.log(`(server) list heartbeats: ${JSON.stringify(call.request, null, 2)}`)
        }
        try {
            const heartbeats = await this.database.getHeartbeats()
            callback(null, { heartbeats: heartbeats })
        } catch (err) {
            callback(new Error('Unable to list heartbeats: ' + err), null)
        }
    }

    public async readHeartbeat(call: ServerUnaryCall<HeartbeatId, Heartbeat>, callback: sendUnaryData<Heartbeat>) {
        if (call.request) {
            console.log(`(server) read heartbeat: ${JSON.stringify(call.request, null, 2)}`)
        }

        try {
            const heartbeat = await this.database.getHeartbeat(call.request)
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