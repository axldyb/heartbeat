import type * as grpc from '@grpc/grpc-js';
import type { MessageTypeDefinition } from '@grpc/proto-loader';

import type { HeartbeatServiceClient as _heartbeat_HeartbeatServiceClient, HeartbeatServiceDefinition as _heartbeat_HeartbeatServiceDefinition } from './heartbeat/HeartbeatService';

type SubtypeConstructor<Constructor extends new (...args: any) => any, Subtype> = {
  new(...args: ConstructorParameters<Constructor>): Subtype;
};

export interface ProtoGrpcType {
  google: {
    protobuf: {
      Timestamp: MessageTypeDefinition
    }
  }
  heartbeat: {
    Empty: MessageTypeDefinition
    Heartbeat: MessageTypeDefinition
    HeartbeatClient: MessageTypeDefinition
    HeartbeatCount: MessageTypeDefinition
    HeartbeatDevice: MessageTypeDefinition
    HeartbeatId: MessageTypeDefinition
    HeartbeatList: MessageTypeDefinition
    HeartbeatLocation: MessageTypeDefinition
    HeartbeatService: SubtypeConstructor<typeof grpc.Client, _heartbeat_HeartbeatServiceClient> & { service: _heartbeat_HeartbeatServiceDefinition }
    newHeartbeat: MessageTypeDefinition
    result: MessageTypeDefinition
  }
}

