import { HeartbeatServer } from './server'
import { HeartbeatService, Environment } from './heartbeat-service'
import { ServiceHandler } from './service-handlers'
import { ServerUnaryCall, sendUnaryData, ServerWritableStream } from '@grpc/grpc-js'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'
import { result } from '../proto/heartbeat/result'
import { HeartbeatId } from '../proto/heartbeat/HeartbeatId'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Empty } from '../proto/heartbeat/Empty'
import { HeartbeatList } from '../proto/heartbeat/HeartbeatList'
import { HeartbeatCount } from '../proto/heartbeat/HeartbeatCount'
import { HeartbeatServiceHandlers } from '../proto/heartbeat/HeartbeatService'
import { SchemaValidator } from './utils/schema-validator'

const environment = process.env.ENVIRONMENT || 'development' as Environment
const database = new HeartbeatService(Environment.development)
const schemaValidator = new SchemaValidator()
const serviceHandler = new ServiceHandler(database, schemaValidator)

const handlers: HeartbeatServiceHandlers = {
    createHeartbeat(call: ServerUnaryCall<newHeartbeat, result>, callback: sendUnaryData<result>) {
        return serviceHandler.createHeartbeat(call, callback)
    },
    listHeartbeats(call: ServerUnaryCall<Empty, HeartbeatList>, callback: sendUnaryData<HeartbeatList>) {
        return serviceHandler.listHeartbeats(call, callback)
    },
    readHeartbeat(call: ServerUnaryCall<HeartbeatId, Heartbeat>, callback: sendUnaryData<Heartbeat>) {
        return serviceHandler.readHeartbeat(call, callback)
    },
    streamHeartbeatCount(call: ServerWritableStream<Empty, HeartbeatCount>) {
        return serviceHandler.streamHeartbeatCount(call)
    }
}

const host = '0.0.0.0'
const port = '9090'
const server = new HeartbeatServer(host, port, handlers)
server.start()