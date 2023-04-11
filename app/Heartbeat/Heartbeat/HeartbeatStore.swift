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
    var isStreaming: Bool { get }
    var eventSubscribers: [HeartbeatEventSubscriber] { get set }

    func startHeartbeatStream()
    func stopHeartbeatStream()
    func createHeartbeat()
}

extension HeartbeatStore {

    mutating public func add(eventSubscriber: HeartbeatEventSubscriber) {
        guard eventSubscribers.firstIndex(where: { subscriber in subscriber === eventSubscriber}) == nil else {
            return
        }
        eventSubscribers.append(eventSubscriber)
    }

    mutating public func remove(eventSubscriber: HeartbeatEventSubscriber) {
        if let index = eventSubscribers.firstIndex(where: { subscriber in subscriber === eventSubscriber}) {
            eventSubscribers.remove(at: index)
        }
    }
}

@MainActor
protocol HeartbeatEventSubscriber: AnyObject {
    func didUpdateHeartbeatCounter(newCount: Int)
    func didUpdateLastHeartbeat(lastHeartbeat: Heartbeat_Heartbeat)
}

class HeartbeatServiceStore: HeartbeatStore {

    public var eventSubscribers: [HeartbeatEventSubscriber] = []
    public var isStreaming: Bool = false

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
            self?.eventSubscribers.forEach { subscriber in
                DispatchQueue.main.async {
                    subscriber.didUpdateHeartbeatCounter(newCount: Int(heartbeatCount.count))
                }
            }
        }
    }

    private func startLastHeartbeatStream() {
        heartbeatService.startLastHeartbeatStream { [weak self] lastHeartbeat in
            self?.logger.info("Last heartbeat: \(lastHeartbeat)")
            self?.eventSubscribers.forEach { subscriber in
                DispatchQueue.main.async {
                    subscriber.didUpdateLastHeartbeat(lastHeartbeat: lastHeartbeat)
                }
            }
        }
    }
}

class PreviewHeartbeatStore: HeartbeatStore {

    public var eventSubscribers: [HeartbeatEventSubscriber] = []
    public var isStreaming: Bool = false

    private var timer: DispatchSourceTimer?
    private var count = 0

    func startHeartbeatStream() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer!.schedule(deadline: .now(), repeating: .seconds(1))
        timer!.setEventHandler(handler: { [weak self] in
            self?.count = self != nil ? self!.count + 1 : 0
            self?.eventSubscribers.forEach { subscriber in
                DispatchQueue.main.async {
                    subscriber.didUpdateHeartbeatCounter(newCount: self?.count ?? 0)
                }
            }
        })
        timer!.resume()
        isStreaming = true
    }

    func stopHeartbeatStream() {
        timer?.cancel()
        timer = nil
        isStreaming = false
    }

    func createHeartbeat() {
        count = count + 1
    }

    deinit {
        timer?.cancel()
        timer = nil
    }
}
