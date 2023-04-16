//
//  HeartbeatAnnotation.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import MapKit

class HeartbeatAnnotation: NSObject, MapViewAnnotation, Identifiable {

    let coordinate: CLLocationCoordinate2D

    let title: String?

    let id = UUID()

    let clusteringIdentifier: String? = "exampleCluster"

    let glyphImage: UIImage? = UIImage(systemName: "mappin")

    let tintColor: UIColor? = .blue

    init(title: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }

}
