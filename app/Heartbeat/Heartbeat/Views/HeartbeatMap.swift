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

    @EnvironmentObject private var heartbeatStore: HeartbeatStore

    @State private var currentHeartbeatRegion: MKCoordinateRegion = HeartbeatMap.defaultRegion

    var body: some View {
        VStack {
            if let heartbeat = heartbeatStore.lastHeartbeat {
                Map(
                    coordinateRegion: $currentHeartbeatRegion,
                    annotationItems: [heartbeat]
                ) { heartbeatUpdate in
                    MapAnnotation(
                        coordinate: heartbeatUpdate.region.center,
                        anchorPoint: CGPoint(x: 0.5, y: 1.0)
                    ) {
                        Image(systemName: "mappin")
                            .foregroundColor(.blue)
                            .font(.system(size: 30, weight: .bold))
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onChange(of: heartbeatStore.lastHeartbeat) { newValue in
                    currentHeartbeatRegion = newValue?.region ?? HeartbeatMap.defaultRegion
                }
                .onAppear {
                    currentHeartbeatRegion = heartbeat.region
                }
                Text(heartbeat.locationName)
                Text("\(heartbeat.timestamp.date.formatted(.dateTime))")
            } else {
                ProgressView()
            }
        }
    }

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
