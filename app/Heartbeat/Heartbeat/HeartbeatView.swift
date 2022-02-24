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

    public let dependencyContainer: DependencyContainer

    @StateObject var viewModel: HeartbeatViewModel

    var body: some View {
        VStack {
            HeartbeatMap(viewModel: dependencyContainer.viewModelFactory.createHeartbeatMapViewModel())
            Text("Heartbeats: \(viewModel.heartbeatCount)")
                .padding()
                .modifier(TitleModifier())
            Button("Create Heartbeat") {
                viewModel.createHeartbeat()
            }
            .buttonStyle(BlueButton())
        }
    }
}

class HeartbeatViewModel: ObservableObject {

    @Published var heartbeatCount: Int = 0

    private let store: HeartbeatStore

    init(store: HeartbeatStore) {
        self.store = store
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
            HeartbeatView(dependencyContainer: dependencyContainer, viewModel: dependencyContainer.viewModelFactory.createHeartbeatViewModel())
        }
    }
}
