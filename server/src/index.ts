import { HeartbeatServer } from './server'
import { HeartbeatDatabaseService, Environment } from './heartbeat-database-service'
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
import { IpInfoService } from './ip-info-service'
import { QueryParams } from '../../rest-api/proto/heartbeat/QueryParams'
import { LastHeartbeatStream } from './last-heartbeat-stream'

const environment = process.env.NODE_ENV || 'development'
const inInfoService = new IpInfoService()
const database = new HeartbeatDatabaseService(environment as Environment, inInfoService)
const schemaValidator = new SchemaValidator()
const serviceHandler = new ServiceHandler(database, schemaValidator, inInfoService)

const handlers: HeartbeatServiceHandlers = {
    createHeartbeat(call: ServerUnaryCall<newHeartbeat, result>, callback: sendUnaryData<result>) {
        return serviceHandler.createHeartbeat(call, callback)
    },
    listHeartbeats(call: ServerUnaryCall<QueryParams, HeartbeatList>, callback: sendUnaryData<HeartbeatList>) {
        return serviceHandler.listHeartbeats(call, callback)
    },
    readHeartbeat(call: ServerUnaryCall<HeartbeatId, Heartbeat>, callback: sendUnaryData<Heartbeat>) {
        return serviceHandler.readHeartbeat(call, callback)
    },
    streamHeartbeatCount(call: ServerWritableStream<Empty, HeartbeatCount>) {
        return serviceHandler.streamHeartbeatCount(call)
    },
    streamLastHeartbeat(call: ServerWritableStream<Empty, Heartbeat>) {
        return serviceHandler.streamLastHeartbeat(call)
    }
}

const host = '0.0.0.0'
const port = '9090'
const server = new HeartbeatServer(host, port, handlers)
server.start()