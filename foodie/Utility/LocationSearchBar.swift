//
//  LocationSearchBar.swift
//  foodie
//
//  Created by Jae Hyun on 5/24/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI

class LocalSearchCompleterService: NSObject, MKLocalSearchCompleterDelegate, ObservableObject {
    let completer: MKLocalSearchCompleter = MKLocalSearchCompleter()
    @Published var results: [String] = []

    override init() {
        super.init()
        completer.delegate = self
        let center = CLLocationCoordinate2D()
        completer.region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        completer.resultTypes = .address
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let addresses = completer.results.map { result in
            result.title + " " + result.subtitle
        }
        
        results = addresses
    }

    func autocomplete(search: String) {
        completer.queryFragment = search
    }

}
