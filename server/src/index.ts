import { HeartbeatServer } from './server'
import { DatabaseService, Environment } from './database-service'
import { ServiceHandler } from './service-handlers'

import { ServerUnaryCall, sendUnaryData } from '@grpc/grpc-js'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'
import { result } from '../proto/heartbeat/result'
import { HeartbeatId } from '../proto/heartbeat/HeartbeatId'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Empty } from '../proto/heartbeat/Empty'
import { HeartbeatList } from '../proto/heartbeat/HeartbeatList'
import { HeartbeatServiceHandlers } from '../proto/heartbeat/HeartbeatService'

const environment = process.env.ENVIRONMENT || 'development' as Environment
const database = new DatabaseService(Environment.development)
const serviceHandler = new ServiceHandler(database)

const handlers: HeartbeatServiceHandlers = {
    createHeartbeat(call: ServerUnaryCall<newHeartbeat, result>, callback: sendUnaryData<result>) {
        return serviceHandler.createHeartbeat(call, callback)
    },
    listHeartbeats(call: ServerUnaryCall<Empty, HeartbeatList>, callback: sendUnaryData<HeartbeatList>) {
        return serviceHandler.listHeartbeats(call, callback)
    },
    readHeartbeat(call: ServerUnaryCall<HeartbeatId, Heartbeat>, callback: sendUnaryData<Heartbeat>) {
        return serviceHandler.readHeartbeat(call, callback)
    }
}

const host = '0.0.0.0'
const port = '9090'
const server = new HeartbeatServer(host, port, handlers)
server.start()