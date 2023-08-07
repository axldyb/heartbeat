//
//  HeartbeatService.swift
//  HeartbeatKit
//
//  Created by Aksel Dybdal on 07/11/2021.
//

import Foundation
import GRPC
import NIO
import Logging

public class HeartbeatService {

    private let logger: Logger
    private let group: MultiThreadedEventLoopGroup
    private let channel: GRPCChannel
    private let serviceClient: Heartbeat_HeartbeatServiceClient
    fileprivate let heartbeatQueue = DispatchQueue(label: "axldyb.Heartbeat")

    private var heartbeatCountStream: ServerStreamingCall<Heartbeat_Empty, Heartbeat_HeartbeatCount>?
    private var lastHeartbeatStream: ServerStreamingCall<Heartbeat_Empty, Heartbeat_Heartbeat>?

    public init() {
        logger = Logger(label: "HeartbeatService", factory: StreamLogHandler.standardOutput(label:))

        // TODO: To prevent warnings for hanging main thread we need to chnage this to be created on a background thread.
        // We can have our code running on a worker background thread and post updates on a specified thread (with a default to main).
        // https://github.com/apple/swift-nio/issues/2223
        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        // Configure the channel, we're not using TLS so the connection is `insecure`.
        channel = try! GRPCChannelPool.with(
          target: .host("heartbeat.axldyb.com", port: 9090),
          transportSecurity: .plaintext,
          eventLoopGroup: group
        ) { conf in
            conf.backgroundActivityLogger = Logger(label: "gRPC", factory: StreamLogHandler.standardOutput(label:))
        }

        // Provide the connection to the generated client.
        serviceClient = Heartbeat_HeartbeatServiceClient(channel: channel)
    }

    deinit {
        // Make sure the group is shutdown when we're done with it.
        try! group.syncShutdownGracefully()

        // Close the connection when we're done with it.
        try! channel.close().wait()
    }
}

public extension HeartbeatService {

    func createHeartbeat() {
        let client = Heartbeat_HeartbeatClient.with { c in
            c.id = Bundle.main.bundleIdentifier ?? "<unknown>"
            c.name = Bundle.main.displayName ?? "<unknown>"
            c.version = "\(String(describing: Bundle.main.appVersion ?? "<unknown>")) (\(String(describing: Bundle.main.buildVersion ?? "<unknown>")))"
        }

        let device = Heartbeat_HeartbeatDevice.with { d in
            d.id = Device.current.id
            d.name = Device.current.name
            d.os = Device.current.os
            d.osVersion = Device.current.osVersion
            d.model = Device.current.model
            d.language = Bundle.main.preferredLocalizations.first ?? "<unknown>"
        }

        let newHeartbeat = Heartbeat_newHeartbeat.with { hb in
            hb.client = client
            hb.device = device
        }

        heartbeatQueue.async { [weak self] in
            let request = self?.serviceClient.createHeartbeat(newHeartbeat)
            guard let request = request else {
                return
            }

            do {
                let response = try request.response.wait()
                self?.logger.info("Heartbeat created: \(response.status)")
            } catch {
                self?.logger.error("Heartbeat failed: \(error)")
            }
        }
    }

    func listHeartbeats(handler: @escaping (Heartbeat_HeartbeatList?) -> Void) {
        heartbeatQueue.async { [weak self] in
            guard let aSelf = self else {
                handler(nil)
                return
            }

            let data = Heartbeat_QueryParams()
            let request = aSelf.serviceClient.listHeartbeats(data)

            DispatchQueue.main.async {
                do {
                    let response = try request.response.wait()
                    handler(response)
                } catch {
                    self?.logger.error("Listing heartbeats failed: \(error)")
                    handler(nil)
                }
            }
        }
    }

    func startHeartbeatCountStream(handler: @escaping (Heartbeat_HeartbeatCount) -> Void) {
        if let existingStream = heartbeatCountStream {
            existingStream.cancel(promise: nil)
        }

        heartbeatQueue.async { [weak self] in
            guard let aSelf = self else {
                return
            }

            let data = Heartbeat_Empty()
            let stream = aSelf.serviceClient.streamHeartbeatCount(data) { count in
                DispatchQueue.main.async {
                    handler(count)
                }
            }

            stream.status.whenFailure { error in
                self?.logger.error("startHeartbeatCountStream whenFailure: \(error)")
            }

            stream.status.whenSuccess{ status in
                // whenSuccess: unavailable (14): Transport became inactive
                // whenSuccess: deadline exceeded (4): Timed out waiting for an HTTP/2 stream from the connection pool
                // whenSuccess: cancelled (1): RPC was cancelled by the client, cause: RPC was cancelled by the client
                self?.logger.info("startHeartbeatCountStream whenSuccess: \(status)")
            }

            aSelf.heartbeatCountStream = stream
        }
    }

    func stopHeartbeatCountStream() {
        heartbeatCountStream?.cancel(promise: nil)
    }

    func startLastHeartbeatStream(handler: @escaping (Heartbeat_Heartbeat) -> Void) {
        if let existingStream = lastHeartbeatStream {
            existingStream.cancel(promise: nil)
        }

        heartbeatQueue.async { [weak self] in
            guard let aSelf = self else {
                return
            }

            let data = Heartbeat_Empty()
            let stream = aSelf.serviceClient.streamLastHeartbeat(data) { lastHeartbeat in
                DispatchQueue.main.async {
                    handler(lastHeartbeat)
                }
            }

            stream.status.whenFailure { error in
                self?.logger.error("startLastHeartbeatStream whenFailure: \(error)")
            }

            stream.status.whenSuccess{ status in
                self?.logger.info("startLastHeartbeatStream whenSuccess: \(status)")
            }

            aSelf.lastHeartbeatStream = stream
        }
    }

    func stopLastHeartbeatStream() {
        lastHeartbeatStream?.cancel(promise: nil)
    }
}
