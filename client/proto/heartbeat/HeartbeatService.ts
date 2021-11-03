// Original file: heartbeat.proto

import type * as grpc from '@grpc/grpc-js'
import type { MethodDefinition } from '@grpc/proto-loader'
import type { Empty as _heartbeat_Empty, Empty__Output as _heartbeat_Empty__Output } from '../heartbeat/Empty';
import type { Heartbeat as _heartbeat_Heartbeat, Heartbeat__Output as _heartbeat_Heartbeat__Output } from '../heartbeat/Heartbeat';
import type { HeartbeatId as _heartbeat_HeartbeatId, HeartbeatId__Output as _heartbeat_HeartbeatId__Output } from '../heartbeat/HeartbeatId';
import type { HeartbeatList as _heartbeat_HeartbeatList, HeartbeatList__Output as _heartbeat_HeartbeatList__Output } from '../heartbeat/HeartbeatList';
import type { newHeartbeat as _heartbeat_newHeartbeat, newHeartbeat__Output as _heartbeat_newHeartbeat__Output } from '../heartbeat/newHeartbeat';
import type { result as _heartbeat_result, result__Output as _heartbeat_result__Output } from '../heartbeat/result';

export interface HeartbeatServiceClient extends grpc.Client {
  createHeartbeat(argument: _heartbeat_newHeartbeat, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  createHeartbeat(argument: _heartbeat_newHeartbeat, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  createHeartbeat(argument: _heartbeat_newHeartbeat, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  createHeartbeat(argument: _heartbeat_newHeartbeat, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  createHeartbeat(argument: _heartbeat_newHeartbeat, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  createHeartbeat(argument: _heartbeat_newHeartbeat, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  createHeartbeat(argument: _heartbeat_newHeartbeat, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  createHeartbeat(argument: _heartbeat_newHeartbeat, callback: (error?: grpc.ServiceError, result?: _heartbeat_result__Output) => void): grpc.ClientUnaryCall;
  
  listHeartbeats(argument: _heartbeat_Empty, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  listHeartbeats(argument: _heartbeat_Empty, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  listHeartbeats(argument: _heartbeat_Empty, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  listHeartbeats(argument: _heartbeat_Empty, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  listHeartbeats(argument: _heartbeat_Empty, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  listHeartbeats(argument: _heartbeat_Empty, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  listHeartbeats(argument: _heartbeat_Empty, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  listHeartbeats(argument: _heartbeat_Empty, callback: (error?: grpc.ServiceError, result?: _heartbeat_HeartbeatList__Output) => void): grpc.ClientUnaryCall;
  
  readHeartbeat(argument: _heartbeat_HeartbeatId, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  readHeartbeat(argument: _heartbeat_HeartbeatId, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  readHeartbeat(argument: _heartbeat_HeartbeatId, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  readHeartbeat(argument: _heartbeat_HeartbeatId, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  readHeartbeat(argument: _heartbeat_HeartbeatId, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  readHeartbeat(argument: _heartbeat_HeartbeatId, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  readHeartbeat(argument: _heartbeat_HeartbeatId, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  readHeartbeat(argument: _heartbeat_HeartbeatId, callback: (error?: grpc.ServiceError, result?: _heartbeat_Heartbeat__Output) => void): grpc.ClientUnaryCall;
  
}

export interface HeartbeatServiceHandlers extends grpc.UntypedServiceImplementation {
  createHeartbeat: grpc.handleUnaryCall<_heartbeat_newHeartbeat__Output, _heartbeat_result>;
  
  listHeartbeats: grpc.handleUnaryCall<_heartbeat_Empty__Output, _heartbeat_HeartbeatList>;
  
  readHeartbeat: grpc.handleUnaryCall<_heartbeat_HeartbeatId__Output, _heartbeat_Heartbeat>;
  
}

export interface HeartbeatServiceDefinition extends grpc.ServiceDefinition {
  createHeartbeat: MethodDefinition<_heartbeat_newHeartbeat, _heartbeat_result, _heartbeat_newHeartbeat__Output, _heartbeat_result__Output>
  listHeartbeats: MethodDefinition<_heartbeat_Empty, _heartbeat_HeartbeatList, _heartbeat_Empty__Output, _heartbeat_HeartbeatList__Output>
  readHeartbeat: MethodDefinition<_heartbeat_HeartbeatId, _heartbeat_Heartbeat, _heartbeat_HeartbeatId__Output, _heartbeat_Heartbeat__Output>
}
