//
//  DependencyContainer.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 23/02/2022.
//

import Foundation

protocol DependencyContainer {
    var store: HeartbeatStore { get }
    var viewModelFactory: ViewModelFactory { get }
}

class HeartbeatDependencies: DependencyContainer {

    let store: HeartbeatStore
    let viewModelFactory: ViewModelFactory

    init() {
        self.store = HeartbeatServiceStore()
        self.viewModelFactory = ViewModelFactory(store: self.store)
    }
}

class PreviewDependencies: DependencyContainer {

    let store: HeartbeatStore
    let viewModelFactory: ViewModelFactory

    init() {
        self.store = PreviewHeartbeatStore()
        self.viewModelFactory = ViewModelFactory(store: self.store)
    }
}
