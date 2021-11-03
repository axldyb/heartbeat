import * as protoLoader from '@grpc/proto-loader'
import * as grpc from '@grpc/grpc-js'
import { ProtoGrpcType } from '../../proto/heartbeat'
import { Request, Response } from 'express'
import { HeartbeatServiceClient } from '../../proto/heartbeat/HeartbeatService'

function getClient(): HeartbeatServiceClient {
    const packageDefinition = protoLoader.loadSync('./proto/heartbeat.proto')
    const proto = (grpc.loadPackageDefinition(packageDefinition) as unknown) as ProtoGrpcType
    const credentials = grpc.credentials.createInsecure() as grpc.ChannelCredentials
    const client = new proto.heartbeat.HeartbeatService('server:9090', credentials)
    return client
}

const client = getClient()

// handlers
const listHeartbeats = (req: Request, res: Response) => {
    console.log('list heartbeats')
    client.listHeartbeats({}, (err, result) => {
        console.log('heartbeats: ' + JSON.stringify(result, null, 2))
        console.log('heartbeats: ' + JSON.stringify(err, null, 2))
        res.json(result)
    })
}
const readHeartbeat = (req: Request, res: Response) => {
    res.json({ status: 'not implemented' })
}
const createHeartbeat = (req: Request, res: Response) => {
    res.json({ status: 'not implemented' })
}

export {
    listHeartbeats,
    readHeartbeat,
    createHeartbeat
}