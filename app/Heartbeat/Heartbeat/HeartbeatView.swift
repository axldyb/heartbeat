//
//  HeartbeatView.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 22/02/2022.
//

import SwiftUI
import HeartbeatKit
import Logging
import MapKit

struct HeartbeatView: View {

    @StateObject var viewModel: HeartbeatViewModel

    private let dependencyContainer: DependencyContainer

    init(dependencyContainer: DependencyContainer) {
        self._viewModel = StateObject(wrappedValue: HeartbeatViewModel(store: dependencyContainer.store))
        self.dependencyContainer = dependencyContainer
    }

    var body: some View {
        VStack {
            HeartbeatMap(dependencyContainer: dependencyContainer)
            Text("Heartbeats: \(viewModel.heartbeatCount)")
                .padding()
                .modifier(TitleModifier())
            Button("Create Heartbeat") {
                viewModel.createHeartbeat()
            }
            .buttonStyle(BlueButton())
        }
        .onAppear {
            viewModel.startStreamingHeartbeatCount()
        }
    }
}

class HeartbeatViewModel: ObservableObject {

    @Published var heartbeatCount: Int = 0

    private let store: HeartbeatStore

    init(store: HeartbeatStore) {
        self.store = store
    }

    func startStreamingHeartbeatCount() {
        self.store.startHeartbeatCountStream { [weak self] newCount in
            self?.heartbeatCount = newCount
        }
    }

    func createHeartbeat() {
        self.store.createHeartbeat()
    }
}

struct HeartbeatView_Previews: PreviewProvider {

    static var previews: some View {
        let dependencyContainer = PreviewDependencies()

        Group {
            HeartbeatView(dependencyContainer: dependencyContainer)
        }
    }
}
