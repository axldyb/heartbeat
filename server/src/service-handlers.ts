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

    public createHeartbeat(call: ServerUnaryCall<newHeartbeat, result>, callback: sendUnaryData<result>) {
        if (call.request) {
            console.log(`(server) create heartbeat: ${JSON.stringify(call.request, null, 2)}`)
        }
        callback(null, {
            status: 'OK',
        })
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

    public readHeartbeat(call: ServerUnaryCall<HeartbeatId, Heartbeat>, callback: sendUnaryData<Heartbeat>) {
        if (call.request) {
            console.log(`(server) read heartbeat: ${JSON.stringify(call.request, null, 2)}`)
        }
        callback(null, {})
    }
}