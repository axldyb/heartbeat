//
//  MapViewAnnotation.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import Foundation
import MapKit

#if canImport(UIKit)
import UIKit
#endif

import SwiftUI

protocol MapViewAnnotation: MKAnnotation {

    /**
     Identifier for clustering annotations. Setting to a non-`nil` value marks the annotation as participant in clustering.

    - SeeAlso: MKAnnotationView.clusteringIdentifier
     */
    var clusteringIdentifier: String? {
        get
    }

#if os(iOS)
    /**
     The image to display as a glyph in the annotation's view.
     */
    @available(iOS 13.0, *)
    var glyphImage: UIImage? {
        get
    }

    /**
     The tint color of the annotations's view.
     */
    @available(iOS 13.0, *)
    var tintColor: UIColor? {
        get
    }

#else
    /**
     The image to display as a glyph in the annotation's view.
     */
    @available(iOS 13.0, *)
    var glyphImage: NSImage? {
        get
    }

    /**
     The tint color of the annotations's view.
     */
    @available(iOS 13.0, *)
    var tintColor: NSColor? {
        get
    }
#endif

}
