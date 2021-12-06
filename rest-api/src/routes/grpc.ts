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
        res.json(result)
    })
}
const readHeartbeat = (req: Request, res: Response) => {
    const payload = { id: req.params.id }

    client.readHeartbeat(payload, (err, result) => {
        if (err) {
            console.error(err)
            res.json(err)
        } else {
            res.json(result)
        }
    })
}
const createHeartbeat = (req: Request, res: Response) => {
    const payload = { client: req.body.client, device: req.body.device }
    client.createHeartbeat(payload, (err, result) => {
        if (err) {
            console.error(err)
            res.json(err)
        } else {
            res.json(result)
        }
    })
}

export {
    listHeartbeats,
    readHeartbeat,
    createHeartbeat
}