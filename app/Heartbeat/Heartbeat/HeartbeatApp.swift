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

    private let heartbeatStore: HeartbeatStore

    init() {
        UIApplication.shared.isIdleTimerDisabled = true
        heartbeatStore = HeartbeatStore()
    }

    var body: some Scene {
        WindowGroup {
            HeartbeatView()
                .environmentObject(heartbeatStore)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                NSLog("App State: Active")
                heartbeatStore.startHeartbeatStream()
            case .background:
                NSLog("App State: Background")
                heartbeatStore.stopHeartbeatStream()
            case .inactive:
                NSLog("App State: Inactive")
                heartbeatStore.stopHeartbeatStream()
            @unknown default:
                NSLog("App State: Unknown")
            }
        }
    }
}
