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

@MainActor class HeartbeatViewModel: ObservableObject, HeartbeatEventSubscriber {

    @Published var heartbeatCount: Int = 0

    private var store: HeartbeatStore

    init(store: HeartbeatStore) {
        self.store = store
        self.store.add(eventSubscriber: self)
    }

    deinit {
        store.remove(eventSubscriber: self)
    }

    func startStreamingHeartbeatCount() {
        store.startHeartbeatStream()
    }

    func didUpdateHeartbeatCounter(newCount: Int) {
        heartbeatCount = newCount
    }

    func didUpdateLastHeartbeat(lastHeartbeat: Heartbeat_Heartbeat) {
        // Don't care
    }

    func createHeartbeat() {
        store.createHeartbeat()
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
