//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: heartbeat.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `Heartbeat_HeartbeatServiceClient`, then call methods of this protocol to make API calls.
internal protocol Heartbeat_HeartbeatServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Heartbeat_HeartbeatServiceClientInterceptorFactoryProtocol? { get }

  func listHeartbeats(
    _ request: Heartbeat_Empty,
    callOptions: CallOptions?
  ) -> UnaryCall<Heartbeat_Empty, Heartbeat_HeartbeatList>

  func readHeartbeat(
    _ request: Heartbeat_HeartbeatId,
    callOptions: CallOptions?
  ) -> UnaryCall<Heartbeat_HeartbeatId, Heartbeat_Heartbeat>

  func createHeartbeat(
    _ request: Heartbeat_newHeartbeat,
    callOptions: CallOptions?
  ) -> UnaryCall<Heartbeat_newHeartbeat, Heartbeat_result>
}

extension Heartbeat_HeartbeatServiceClientProtocol {
  internal var serviceName: String {
    return "heartbeat.HeartbeatService"
  }

  /// Unary call to listHeartbeats
  ///
  /// - Parameters:
  ///   - request: Request to send to listHeartbeats.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func listHeartbeats(
    _ request: Heartbeat_Empty,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Heartbeat_Empty, Heartbeat_HeartbeatList> {
    return self.makeUnaryCall(
      path: "/heartbeat.HeartbeatService/listHeartbeats",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makelistHeartbeatsInterceptors() ?? []
    )
  }

  /// Unary call to readHeartbeat
  ///
  /// - Parameters:
  ///   - request: Request to send to readHeartbeat.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func readHeartbeat(
    _ request: Heartbeat_HeartbeatId,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Heartbeat_HeartbeatId, Heartbeat_Heartbeat> {
    return self.makeUnaryCall(
      path: "/heartbeat.HeartbeatService/readHeartbeat",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makereadHeartbeatInterceptors() ?? []
    )
  }

  /// Unary call to createHeartbeat
  ///
  /// - Parameters:
  ///   - request: Request to send to createHeartbeat.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func createHeartbeat(
    _ request: Heartbeat_newHeartbeat,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Heartbeat_newHeartbeat, Heartbeat_result> {
    return self.makeUnaryCall(
      path: "/heartbeat.HeartbeatService/createHeartbeat",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makecreateHeartbeatInterceptors() ?? []
    )
  }
}

internal protocol Heartbeat_HeartbeatServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'listHeartbeats'.
  func makelistHeartbeatsInterceptors() -> [ClientInterceptor<Heartbeat_Empty, Heartbeat_HeartbeatList>]

  /// - Returns: Interceptors to use when invoking 'readHeartbeat'.
  func makereadHeartbeatInterceptors() -> [ClientInterceptor<Heartbeat_HeartbeatId, Heartbeat_Heartbeat>]

  /// - Returns: Interceptors to use when invoking 'createHeartbeat'.
  func makecreateHeartbeatInterceptors() -> [ClientInterceptor<Heartbeat_newHeartbeat, Heartbeat_result>]
}

internal final class Heartbeat_HeartbeatServiceClient: Heartbeat_HeartbeatServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Heartbeat_HeartbeatServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the heartbeat.HeartbeatService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Heartbeat_HeartbeatServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}
