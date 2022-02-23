import { ServerWritableStream } from '@grpc/grpc-js'
import { Empty } from '../proto/heartbeat/Empty'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'

export class LastHeartbeatStream {
    call: ServerWritableStream<Empty, Heartbeat>
    active: boolean

    constructor(call: ServerWritableStream<Empty, Heartbeat>, active: boolean = true) {
        this.call = call
        this.active = active
    }
}