//
//  ViewModelFactory.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 23/02/2022.
//

import Foundation

class ViewModelFactory {

    let store: HeartbeatStore

    init(store: HeartbeatStore) {
        self.store = store
    }

    func createHeartbeatViewModel() -> HeartbeatViewModel {
        return HeartbeatViewModel(store: store)
    }

    func createHeartbeatMapViewModel() -> HeartbeatMapViewModel {
        return HeartbeatMapViewModel(store: store)
    }
}
