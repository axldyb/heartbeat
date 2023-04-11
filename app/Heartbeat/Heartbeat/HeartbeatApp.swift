//
//  HeartbeatApp.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 22/02/2022.
//

import SwiftUI

@main
struct HeartbeatApp: App {

    @Environment(\.scenePhase) var scenePhase

    private let dependencyContainer = HeartbeatDependencies()

    init() {
        UIApplication.shared.isIdleTimerDisabled = true
    }

    var body: some Scene {
        WindowGroup {
            HeartbeatView(dependencyContainer: dependencyContainer)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                NSLog("App State: Active")
                dependencyContainer.store.startHeartbeatStream()
            case .background:
                NSLog("App State: Background")
                dependencyContainer.store.stopHeartbeatStream()
            case .inactive:
                NSLog("App State: Inactive")
                dependencyContainer.store.stopHeartbeatStream()
            @unknown default:
                NSLog("App State: Unknown")
            }
        }
    }
}
