//
//  HeartbeatStore.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 23/02/2022.
//

import Foundation
import HeartbeatKit
import Logging

protocol HeartbeatStore {
    func startHeartbeatCountStream(handler: @escaping (Int) -> Void)
    func startLastHeartbeatStream(handler: @escaping (Heartbeat_Heartbeat) -> Void)
    func createHeartbeat()
}

class HeartbeatServiceStore: HeartbeatStore {

    private let heartbeatService = HeartbeatService()
    private let logger = Logger(label: "HeartbeatServiceStore", factory: StreamLogHandler.standardOutput(label:))

    func startHeartbeatCountStream(handler: @escaping (Int) -> Void) {
        heartbeatService.startHeartbeatCountStream { [weak self] heartbeatCount in
            self?.logger.info("Heartbeats: \(heartbeatCount.count)")
            handler(Int(heartbeatCount.count))
        }
    }

    func startLastHeartbeatStream(handler: @escaping (Heartbeat_Heartbeat) -> Void) {
        heartbeatService.startLastHeartbeatStream { [weak self] lastHeartbeat in
            self?.logger.info("Last heartbeat: \(lastHeartbeat)")
            handler(lastHeartbeat)
        }
    }

    func createHeartbeat() {
        heartbeatService.createHeartbeat()
    }
}

class PreviewHeartbeatStore: HeartbeatStore {

    private var timer: DispatchSourceTimer?
    private var count = 0

    func startHeartbeatCountStream(handler: @escaping (Int) -> Void) {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer!.schedule(deadline: .now(), repeating: .seconds(1))
        timer!.setEventHandler(handler: { [weak self] in
            self?.count = self != nil ? self!.count + 1 : 0
            handler(self?.count ?? 0)
        })
        timer!.resume()
    }

    func startLastHeartbeatStream(handler: @escaping (Heartbeat_Heartbeat) -> Void) {
        // TODO: Stream dummy data
    }

    func createHeartbeat() {
        count = count + 1
    }

    deinit {
        timer = nil
    }
}
