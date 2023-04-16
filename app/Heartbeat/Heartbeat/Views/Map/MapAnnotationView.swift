//
//  MapAnnotationView.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import MapKit

class MapAnnotationView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            guard let mapAnnotation = newValue as? MapViewAnnotation else {
                return
            }

            clusteringIdentifier = mapAnnotation.clusteringIdentifier
            markerTintColor = mapAnnotation.tintColor
            glyphImage = mapAnnotation.glyphImage
        }
    }

}
