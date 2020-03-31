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
        mapView.region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
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

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: MKPointAnnotation.example.coordinate, restaurantName: "Test")
    }
}
