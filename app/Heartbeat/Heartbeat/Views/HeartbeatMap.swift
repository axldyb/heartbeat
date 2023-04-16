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

    /// The heartbeat store to use.
    @EnvironmentObject private var heartbeatStore: HeartbeatStore

    /// The current region to display on the map.
    @State private var currentHeartbeatRegion: MKCoordinateRegion? = nil

    var body: some View {
        VStack {
            if let heartbeat = heartbeatStore.lastHeartbeat {
                MapView(region: $currentHeartbeatRegion, showsUserLocation: false, annotations: heartbeatAnnotations)
                    .edgesIgnoringSafeArea(.all)
                    .onChange(of: heartbeatStore.lastHeartbeat) { newValue in
                        withAnimation {
                            currentHeartbeatRegion = newValue?.region ?? HeartbeatMap.defaultRegion
                        }
                    }
                    .onAppear {
                        withAnimation {
                            currentHeartbeatRegion = heartbeat.region
                        }
                    }

                Text(heartbeat.locationName)
                Text("\(heartbeat.timestamp.date.formatted(.dateTime)) (\(heartbeat.timestamp.date, style: .relative))")
            } else {
                ProgressView()
            }
        }
    }

    /// The annotations to display on the map.
    private var heartbeatAnnotations: [HeartbeatAnnotation] {
        guard let heartbeat = heartbeatStore.lastHeartbeat else {
            return []
        }

        return [HeartbeatAnnotation(coordinate: heartbeat.region.center)]
    }

    /// The default region to display when no heartbeat is available.
    private static var defaultRegion: MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 37.334_900,
                longitude: -122.009_020
            ),
            latitudinalMeters: 50_000,
            longitudinalMeters: 50_000
        )
    }
}
