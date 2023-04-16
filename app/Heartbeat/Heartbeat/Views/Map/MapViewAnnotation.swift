//
//  MapViewAnnotation.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import Foundation
import MapKit

protocol MapViewAnnotation: MKAnnotation {

    /**
     Identifier for clustering annotations. Setting to a non-`nil` value marks the annotation as participant in clustering.

    - SeeAlso: MKAnnotationView.clusteringIdentifier
     */
    var clusteringIdentifier: String? {
        get
    }

    /**
     The image to display as a glyph in the annotation's view.
     */
    var glyphImage: UIImage? {
        get
    }

    /**
     The tint color of the annotations's view.
     */
    var tintColor: UIColor? {
        get
    }

}
