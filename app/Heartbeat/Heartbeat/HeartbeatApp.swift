//
//  HeartbeatApp.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 22/02/2022.
//

import SwiftUI

@main
struct TestSwiftUIApp: App {

    private let dependencyContainer = HeartbeatDependencies()

    var body: some Scene {
        WindowGroup {
            HeartbeatView(dependencyContainer: dependencyContainer, viewModel: dependencyContainer.viewModelFactory.createHeartbeatViewModel())
        }
    }
}
