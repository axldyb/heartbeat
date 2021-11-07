//
//  HeartbeatService.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 07/11/2021.
//

import Foundation
import GRPC
import NIO
import UIKit

class HeartbeatService {

    private let group: MultiThreadedEventLoopGroup
    private let channel: GRPCChannel
    private let serviceClient: Heartbeat_HeartbeatServiceClient

    init() {
        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        // Configure the channel, we're not using TLS so the connection is `insecure`.
        channel = try! GRPCChannelPool.with(
          target: .host("localhost", port: 9090),
          transportSecurity: .plaintext,
          eventLoopGroup: group
        )

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

extension HeartbeatService {

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

        let request = serviceClient.createHeartbeat(newHeartbeat)

        do {
            let response = try request.response.wait()
            print("Heartbeat created: \(response.status)")
        } catch {
            print("Heartbeat failed: \(error)")
        }
    }

    func listHeartbeats() -> Heartbeat_HeartbeatList? {
        let data = Heartbeat_Empty()
        let request = serviceClient.listHeartbeats(data)

        do {
            let response = try request.response.wait()
            return response
        } catch {
            print("Heartbeat failed: \(error)")
            return nil
        }
    }
}
