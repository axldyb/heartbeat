//
//  MKMapView+Extensions.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import Foundation
import MapKit

extension MKMapView {

    /**
     All `MapAnnotations` set on the map view.
     */
    var mapViewAnnotations: [MapViewAnnotation] {
        annotations.compactMap { $0 as? MapViewAnnotation }
    }

    /**
     All `MapAnnotations` selected on the map view.
     */
    var selectedMapViewAnnotations: [MapViewAnnotation] {
        selectedAnnotations.compactMap { $0 as? MapViewAnnotation }
    }

}

extension CLLocationCoordinate2D: Equatable {

    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

}

extension MKCoordinateSpan: Equatable {

    public static func ==(lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }

}
