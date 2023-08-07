//
//  MapView.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import Foundation
import SwiftUI
import MapKit

// https://github.com/sgade/swiftui-mapview
struct MapView {

    // MARK: Properties
    /**
     The map type that is displayed.
     */
    let mapType: MKMapType

    /**
     The region that is displayed.

    Note: The region might not be used as-is, as it might need to be fitted to the view's bounds. See [regionThatFits(_:)](https://developer.apple.com/documentation/mapkit/mkmapview/1452371-regionthatfits).
     */
    @Binding var region: MKCoordinateRegion?

    /**
     Determines whether the map can be zoomed.
    */
    let isZoomEnabled: Bool

    /**
     Determines whether the map can be scrolled.
    */
    let isScrollEnabled: Bool

    /**
     Determines whether the map can be rotated.
    */
    let isRotateEnabled: Bool

    /**
     Determines whether the current user location is displayed.

     This requires the `NSLocationWhenInUseUsageDescription` key in the Info.plist to be set. In addition, you need to call [`CLLocationManager.requestWhenInUseAuthorization()`](https://developer.apple.com/documentation/corelocation/cllocationmanager/1620562-requestwheninuseauthorization) to request for permission.
     */
    let showsUserLocation: Bool

    /**
     Sets the map's user tracking mode.
     */
    let userTrackingMode: MKUserTrackingMode

    /**
     Annotations that are displayed on the map.

     See the `selectedAnnotation` binding for more information about user selection of annotations.

     - SeeAlso: selectedAnnotation
     */
    let annotations: [MapViewAnnotation]

    /**
     The currently selected annotations.

     When the user selects annotations on the map the value of this binding changes.
     Likewise, setting the value of this binding to a value selects the given annotations.
     */
    @Binding var selectedAnnotations: [MapViewAnnotation]

    // MARK: Initializer
    /**
     Creates a new MapView.

     - Parameters:
        - mapType: The map type to display.
        - region: The region to display.
        - showsUserLocation: Whether to display the user's current location.
        - userTrackingMode: The user tracking mode.
        - annotations: A list of `MapAnnotation`s that should be displayed on the map.
        - selectedAnnotation: A binding to the currently selected annotation, or `nil`.
     */
    public init(mapType: MKMapType = .standard,
                region: Binding<MKCoordinateRegion?> = .constant(nil),
                isZoomEnabled: Bool = true,
                isScrollEnabled: Bool = true,
                isRotateEnabled: Bool = true,
                showsUserLocation: Bool = true,
                userTrackingMode: MKUserTrackingMode = .none,
                annotations: [MapViewAnnotation] = [],
                selectedAnnotations: Binding<[MapViewAnnotation]> = .constant([])) {
        self.mapType = mapType
        self._region = region
        self.isZoomEnabled = isZoomEnabled
        self.isScrollEnabled = isScrollEnabled
        self.isRotateEnabled = isRotateEnabled
        self.showsUserLocation = showsUserLocation
        self.userTrackingMode = userTrackingMode
        self.annotations = annotations
        self._selectedAnnotations = selectedAnnotations
    }

    /**
     Updates the annotation property of the `mapView`.
     Calculates the difference between the current and new states and only executes changes on those diff sets.

     - Parameter mapView: The `MKMapView` to configure.
     */
    private func updateAnnotations(in mapView: MKMapView) {
        let currentAnnotations = mapView.mapViewAnnotations
        // remove old annotations
        let obsoleteAnnotations = currentAnnotations.filter { mapAnnotation in
            !annotations.contains { $0.isEqual(mapAnnotation) }
        }
        mapView.removeAnnotations(obsoleteAnnotations)

        // add new annotations
        let newAnnotations = annotations.filter { mapViewAnnotation in
            !currentAnnotations.contains { $0.isEqual(mapViewAnnotation) }
        }
        mapView.addAnnotations(newAnnotations)
    }

    /**
     Updates the selection annotations of the `mapView`.
     Calculates the difference between the current and new selection states and only executes changes on those diff sets.

     - Parameter mapView: The `MKMapView` to configure.
     */
    private func updateSelectedAnnotation(in mapView: MKMapView) {
        // deselect annotations that are not currently selected
        let oldSelections = mapView.selectedMapViewAnnotations.filter { oldSelection in
            !selectedAnnotations.contains {
                oldSelection.isEqual($0)
            }
        }
        for annotation in oldSelections {
            mapView.deselectAnnotation(annotation, animated: false)
        }

        // select all new annotations
        let newSelections = selectedAnnotations.filter { selection in
            !mapView.selectedMapViewAnnotations.contains {
                selection.isEqual($0)
            }
        }
        for annotation in newSelections {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }

    // MARK: - Interaction and delegate implementation

    public func makeCoordinator() -> MapView.Coordinator {
        return Coordinator(for: self)
    }

    public class Coordinator: NSObject, MKMapViewDelegate {

        /**
         Reference to the SwiftUI `MapView`.
        */
        private let context: MapView

        init(for context: MapView) {
            self.context = context
            super.init()
        }

        // MARK: MKMapViewDelegate
        public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let mapAnnotation = view.annotation as? MapViewAnnotation else {
                return
            }

            DispatchQueue.main.async {
                self.context.selectedAnnotations.append(mapAnnotation)
            }
        }

        public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            guard let mapAnnotation = view.annotation as? MapViewAnnotation else {
                return
            }

            guard let index = context.selectedAnnotations.firstIndex(where: { $0.isEqual(mapAnnotation) }) else {
                return
            }

            DispatchQueue.main.async {
                self.context.selectedAnnotations.remove(at: index)
            }
        }

        public func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            DispatchQueue.main.async {
                self.context.region = mapView.region
            }
        }

    }

}

#if os(iOS)
extension MapView: UIViewRepresentable {

    // MARK: - UIViewRepresentable

    public func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        // create view
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        // register custom annotation view classes
        mapView.register(MapAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MapAnnotationClusterView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

        // configure initial view state
        configureView(mapView, context: context)

        return mapView
    }

    public func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // configure view update
        configureView(mapView, context: context)
    }

    // MARK: - Configuring view state
    /**
     Configures the `mapView`'s state according to the current view state.
     */
    private func configureView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // basic map configuration
        mapView.mapType = mapType
        if let mapRegion = region {
            let region = mapView.regionThatFits(mapRegion)

            if region.center != mapView.region.center || region.span != mapView.region.span {
                mapView.setRegion(region, animated: true)
            }
        }
        mapView.isZoomEnabled = isZoomEnabled
        mapView.isScrollEnabled = isScrollEnabled
        mapView.isRotateEnabled = isRotateEnabled
        mapView.showsUserLocation = showsUserLocation
        mapView.userTrackingMode = userTrackingMode

        // annotation configuration
        updateAnnotations(in: mapView)
        updateSelectedAnnotation(in: mapView)
    }
}

#else
extension MapView: NSViewRepresentable {

    func makeNSView(context: NSViewRepresentableContext<MapView>) -> MKMapView {
        // create view
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        // register custom annotation view classes
        mapView.register(MapAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MapAnnotationClusterView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

        // configure initial view state
        configureView(mapView, context: context)

        return mapView
    }

    func updateNSView(_ mapView: MKMapView, context: Context) {
        // configure view update
        configureView(mapView, context: context)
    }

    // MARK: - Configuring view state
    /**
     Configures the `mapView`'s state according to the current view state.
     */
    private func configureView(_ mapView: MKMapView, context: NSViewRepresentableContext<MapView>) {
        // basic map configuration
        mapView.mapType = mapType
        if let mapRegion = region {
            let region = mapView.regionThatFits(mapRegion)

            if region.center != mapView.region.center || region.span != mapView.region.span {
                mapView.setRegion(region, animated: true)
            }
        }
        mapView.isZoomEnabled = isZoomEnabled
        mapView.isScrollEnabled = isScrollEnabled
        mapView.isRotateEnabled = isRotateEnabled
        mapView.showsUserLocation = showsUserLocation
        mapView.userTrackingMode = userTrackingMode

        // annotation configuration
        updateAnnotations(in: mapView)
        updateSelectedAnnotation(in: mapView)
    }
}
#endif
