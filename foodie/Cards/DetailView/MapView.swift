//
//  MapView.swift
//  foodie
//
//  Created by Jae Hyun on 3/30/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var centerCoordinate: CLLocationCoordinate2D
    var restaurantName: String

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = centerCoordinate

        annotation.title = restaurantName
        mapView.addAnnotation(annotation)
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}
