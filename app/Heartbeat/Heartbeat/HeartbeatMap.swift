//
//  HeartbeatMapView.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 23/02/2022.
//

import Foundation
import SwiftUI
import MapKit

struct HeartbeatMap: View {

    @ObservedObject var viewModel: HeartbeatMapViewModel

    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: [viewModel.location]) { location in
            MapAnnotation(coordinate: location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                Circle()
                    .stroke(Color.blue, lineWidth: 3.0)
                    .frame(width: 44, height: 44)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

class HeartbeatMapViewModel: ObservableObject {

    @Published var region = HeartbeatMapViewModel.createCoordinateRegion(
        latitude: 37.334_900,
        longitude: -122.009_020
    )

    @Published var location = HeartbeatLocation(coordinate: CLLocationCoordinate2D(
        latitude: 37.334_900,
        longitude: -122.009_020
    ))

    private let store: HeartbeatStore

    init(store: HeartbeatStore) {
        self.store = store
        self.store.startLastHeartbeatStream { [weak self] lastHeartbeat in
            self?.location = HeartbeatLocation(
                coordinate: CLLocationCoordinate2D(
                    latitude: lastHeartbeat.location.latitude,
                    longitude: lastHeartbeat.location.longitude
                )
            )

            self?.region = HeartbeatMapViewModel.createCoordinateRegion(
                latitude: lastHeartbeat.location.latitude,
                longitude: lastHeartbeat.location.longitude
            )
        }
    }

    private static func createCoordinateRegion(latitude: Double, longitude: Double) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            latitudinalMeters: 50_000,
            longitudinalMeters: 50_000
        )
    }
}


struct HeartbeatLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
