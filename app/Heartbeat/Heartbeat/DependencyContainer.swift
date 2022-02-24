//
//  DependencyContainer.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 23/02/2022.
//

import Foundation

protocol DependencyContainer {
    var store: HeartbeatStore { get }
}

class HeartbeatDependencies: DependencyContainer {

    let store: HeartbeatStore

    init() {
        self.store = HeartbeatServiceStore()
    }
}

class PreviewDependencies: DependencyContainer {

    let store: HeartbeatStore

    init() {
        self.store = PreviewHeartbeatStore()
    }
}
