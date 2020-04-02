//
//  Restaurant.swift
//  foodie
//
//  Created by Jae Hyun on 3/25/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import MapKit

struct RestaurantList: Decodable {
    var businesses: [Restaurant]
}

struct Restaurant: Decodable, Identifiable {
    var id: String = ""
    var name: String = ""
    var image_url: String = ""
    var is_closed: Bool = false
    var url: String = ""
    var phone: String = ""
    var review_count: Int = 0
    var categories: [[String:String]] = []
    var rating: Float = 0.0
    var price: String? = ""
    var location: Location = Location()
    var coordinates: [String: CLLocationDegrees] = [:]
    var photos: [String]?
}

struct Location: Decodable {
    var address1: String = ""
    var address2: String? = ""
    var address3: String? = ""
    var city: String = ""
    var zip_code: String = ""
    var country: String = ""
    var state: String = ""
    var display_address: [String] = []
}
