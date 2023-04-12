//
//  Heartbeat_Heartbeat+Extensions.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 12/04/2023.
//

import Foundation
import MapKit
import HeartbeatKit

extension Heartbeat_Heartbeat: Identifiable {

    var region: MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            latitudinalMeters: 50_000,
            longitudinalMeters: 50_000
        )
    }

    var locationName: String {
        return "\(location.city), \(location.region), \(location.country)"
    }
}
