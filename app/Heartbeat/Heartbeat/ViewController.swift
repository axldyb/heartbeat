//
//  ViewController.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 06/11/2021.
//

import UIKit
import HeartbeatKit
import Logging

class ViewController: UIViewController {

    @IBOutlet weak var heartbeatsLabel: UILabel!

    private let heartbeatService = HeartbeatService()
    private let logger = Logger(label: "ViewController", factory: StreamLogHandler.standardOutput(label:))

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: UIScene.didActivateNotification, object: nil, queue: nil) { [weak self] notification in
            self?.logger.info("didActivateNotification")
            self?.heartbeatService.startHeartbeatCountStream { [weak self] heartbeatCount in
                self?.logger.info("Heartbeats: \(heartbeatCount.count)")
                self?.heartbeatsLabel.text = "Heartbeats: \(heartbeatCount.count)"
            }
        }

        NotificationCenter.default.addObserver(forName: UIScene.willDeactivateNotification, object: nil, queue: nil) { [weak self] notification in
            self?.logger.info("willDeactivateNotification")
            self?.heartbeatService.stopHeartbeatCountStream()
        }
    }

    @IBAction func sendHeartbeat(_ sender: Any) {
        heartbeatService.createHeartbeat()
    }
}

