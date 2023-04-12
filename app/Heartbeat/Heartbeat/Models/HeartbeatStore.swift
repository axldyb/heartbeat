//
//  HeartbeatStore.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 23/02/2022.
//

import Foundation
import HeartbeatKit
import Logging

@MainActor
class HeartbeatStore: ObservableObject {

    @Published public var isStreaming: Bool = false
    @Published public var heartbeatCount: Int = 0
    @Published public var lastHeartbeat: Heartbeat_Heartbeat? = nil

    private let heartbeatService = HeartbeatService()
    private let logger = Logger(label: "HeartbeatServiceStore", factory: StreamLogHandler.standardOutput(label:))

    func startHeartbeatStream() {
        // Are we already streaming?
        guard isStreaming == false else {
            return
        }

        startHeartbeatCountStream()
        startLastHeartbeatStream()
        isStreaming = true
    }

    func stopHeartbeatStream() {
        // Are we already stop streaming?
        guard isStreaming else {
            return
        }

        heartbeatService.stopHeartbeatCountStream()
        heartbeatService.stopLastHeartbeatStream()
        isStreaming = false
    }

    func createHeartbeat() {
        heartbeatService.createHeartbeat()
    }

    private func startHeartbeatCountStream() {
        heartbeatService.startHeartbeatCountStream { [weak self] heartbeatCount in
            self?.logger.info("Heartbeats: \(heartbeatCount.count)")
            self?.heartbeatCount = Int(heartbeatCount.count)
        }
    }

    private func startLastHeartbeatStream() {
        heartbeatService.startLastHeartbeatStream { [weak self] lastHeartbeat in
            self?.logger.info("Last heartbeat: \(lastHeartbeat)")
            self?.lastHeartbeat = lastHeartbeat
        }
    }
}
