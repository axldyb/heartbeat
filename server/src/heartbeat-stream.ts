import { ServerWritableStream } from '@grpc/grpc-js'
import { Empty } from '../proto/heartbeat/Empty'
import { HeartbeatCount } from '../proto/heartbeat/HeartbeatCount'

export class HeartbeatStream {
    call: ServerWritableStream<Empty, HeartbeatCount>
    active: boolean

    constructor(call: ServerWritableStream<Empty, HeartbeatCount>, active: boolean = true) {
        this.call = call
        this.active = active
    }
}