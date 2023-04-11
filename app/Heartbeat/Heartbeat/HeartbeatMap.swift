//
//  HeartbeatMapView.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 23/02/2022.
//

import Foundation
import SwiftUI
import MapKit
import HeartbeatKit

struct HeartbeatMap: View {

    @StateObject var viewModel: HeartbeatMapViewModel

    init(dependencyContainer: DependencyContainer) {
        self._viewModel = StateObject(wrappedValue: HeartbeatMapViewModel(store: dependencyContainer.store))
    }

    var body: some View {
        VStack {
            Map(
                coordinateRegion: $viewModel.heartbeatUpdate.region,
                annotationItems: [viewModel.heartbeatUpdate]
            ) { heartbeatUpdate in
                MapAnnotation(
                    coordinate: heartbeatUpdate.region.center,
                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
                ) {
                    Circle()
                        .stroke(Color.blue, lineWidth: 3.0)
                        .frame(width: 44, height: 44)
                }
            }
            .edgesIgnoringSafeArea(.all)
            Text(viewModel.heartbeatUpdate.locationName)
            Text("\(viewModel.heartbeatUpdate.timestamp.formatted(.dateTime))")
        }
        .onAppear {
            viewModel.startStreamingLocations()
        }
    }
}

@MainActor class HeartbeatMapViewModel: ObservableObject, HeartbeatEventSubscriber {

    @Published var heartbeatUpdate = HeartbeatUpdate.defaultHeartbeatUpdate()

    private var store: HeartbeatStore

    init(store: HeartbeatStore) {
        self.store = store
        self.store.add(eventSubscriber: self)
    }

    deinit {
        store.remove(eventSubscriber: self)
    }

    func startStreamingLocations() {
        store.startHeartbeatStream()
    }

    func didUpdateLastHeartbeat(lastHeartbeat: Heartbeat_Heartbeat) {
        heartbeatUpdate = HeartbeatUpdate(heartbeat: lastHeartbeat)
    }

    func didUpdateHeartbeatCounter(newCount: Int) {
        // don't care
    }
}


struct HeartbeatUpdate: Identifiable {
    let id = UUID()
    var region: MKCoordinateRegion // var, beacuse we need a mutable for the binding in the map
    let locationName: String
    let timestamp: Date

    init(heartbeat: Heartbeat_Heartbeat) {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: heartbeat.location.latitude,
                longitude: heartbeat.location.longitude
            ),
            latitudinalMeters: 50_000,
            longitudinalMeters: 50_000
        )

        self.locationName = "\(heartbeat.location.city), \(heartbeat.location.region), \(heartbeat.location.country)"
        self.timestamp = heartbeat.timestamp.date
    }

    init(region: MKCoordinateRegion, locationName: String, timestamp: Date) {
        self.region = region
        self.locationName = locationName
        self.timestamp = timestamp
    }

    static func defaultHeartbeatUpdate() -> HeartbeatUpdate {
        return HeartbeatUpdate(
            region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 37.334_900,
                    longitude: -122.009_020
                ),
                latitudinalMeters: 50_000,
                longitudinalMeters: 50_000
            ),
            locationName: "Home",
            timestamp: Date()
        )
    }
}
