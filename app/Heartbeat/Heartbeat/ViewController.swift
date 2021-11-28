//
//  ViewController.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 06/11/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heartbeatsLabel: UILabel!

    let heartbeatService = HeartbeatService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func sendHeartbeat(_ sender: Any) {
        heartbeatService.createHeartbeat()
    }
}

