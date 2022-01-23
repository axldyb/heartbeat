//
//  HeartbeatService.swift
//  HeartbeatKit
//
//  Created by Aksel Dybdal on 07/11/2021.
//

import Foundation
import GRPC
import NIO
import UIKit
import Logging

public class HeartbeatService {

    private let logger: Logger
    private let group: MultiThreadedEventLoopGroup
    private let channel: GRPCChannel
    private let serviceClient: Heartbeat_HeartbeatServiceClient
    fileprivate let heartbeatQueue = DispatchQueue(label: "axldyb.Heartbeat")

    private var heartbeatCountStream: ServerStreamingCall<Heartbeat_Empty, Heartbeat_HeartbeatCount>?

    public init() {
        logger = Logger(label: "HeartbeatService", factory: StreamLogHandler.standardOutput(label:))

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
            d.id = UIDevice.current.deviceIdentifier()
            d.name = UIDevice.current.name
            d.os = UIDevice.current.systemName
            d.osVersion = UIDevice.current.systemVersion
            d.model = UIDevice.modelName
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
                self?.logger.error("whenFailure: \(error)")
            }

            stream.status.whenSuccess{ status in
                self?.logger.info("whenSuccess: \(status)")
            }

            aSelf.heartbeatCountStream = stream
        }
    }

    func stopHeartbeatCountStream() {
        heartbeatCountStream?.cancel(promise: nil)
    }
}
