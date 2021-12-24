//
//  ViewController.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 06/11/2021.
//

import UIKit
import HeartbeatKit

class ViewController: UIViewController {

    @IBOutlet weak var heartbeatsLabel: UILabel!

    let heartbeatService = HeartbeatService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        heartbeatService.streamHeartbeatCount { [weak self] heartbeatCount in
            NSLog("Heartbeats: \(heartbeatCount.count)")
            self?.heartbeatsLabel.text = "Heartbeats: \(heartbeatCount.count)"
        }
    }

    @IBAction func sendHeartbeat(_ sender: Any) {
        heartbeatService.createHeartbeat()
    }
}

