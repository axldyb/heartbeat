import * as protoLoader from '@grpc/proto-loader'
import * as grpc from 'grpc'
import { ProtoGrpcType } from '../proto/heartbeat'
import { HeartbeatServiceHandlers } from '../proto/heartbeat/HeartbeatService'

export class HeartbeatServer {

    private server: grpc.Server
    private host: string

    constructor(host: string, port: string, handlers: HeartbeatServiceHandlers) {
        this.host = `${host}:${port}`
        this.server = this.createServer(handlers)
    }

    private createServer(handlers: HeartbeatServiceHandlers): grpc.Server {
        const packageDefinition = protoLoader.loadSync('./proto/heartbeat.proto')
        const proto = (grpc.loadPackageDefinition(packageDefinition) as unknown) as ProtoGrpcType
        const server = new grpc.Server()
        server.addService(proto.heartbeat.HeartbeatService.service, handlers)
        return server
    }

    start() {
        const credentials = grpc.ServerCredentials.createInsecure()
        this.server.bindAsync(this.host, credentials, (err: Error | null, port: number) => {
            if (err) {
                console.error(`Server error: ${err.message}`)
            } else {
                console.log(`Server bound on port: ${port}`)
                this.server.start()
                console.log(`gRPC server running at http://${this.host}`)
            }
        })
    }
}