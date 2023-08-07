//
//  HeartbeatAnnotation.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import MapKit

#if canImport(UIKit)
import UIKit
#endif

@available(iOS, introduced: 13.0)
class HeartbeatAnnotation: NSObject, MapViewAnnotation, Identifiable {

    let coordinate: CLLocationCoordinate2D
    let title: String?
    let id = UUID()
    let clusteringIdentifier: String? = "exampleCluster"

#if canImport(UIKit)
    let glyphImage: UIImage? = UIImage(systemName: "mappin")
    let tintColor: UIColor? = .blue
#else
    let glyphImage: NSImage? = NSImage(systemSymbolName: "mappin", accessibilityDescription: nil)
    let tintColor: NSColor? = .blue
#endif

    init(title: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }

}
