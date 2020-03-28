//
//  Restaurant.swift
//  foodie
//
//  Created by Jae Hyun on 3/25/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct RestaurantList: Decodable {
    var businesses: [Restaurant]
}

struct Restaurant: Decodable, Identifiable {
    var id: String
    var name: String
//    var image_url: String = ""
//    var is_closed: Bool = false
//    var url: String = ""
//    var phone: String = ""
//    var display_phone: String = ""
//    var review_count: Int = 0
//    var categories: [String: String] = ["":""]
//    var rating: Float = 0.0
//    var location: [String: String] = ["":""]
//    var photos: [String] = []
//    var price: String = ""
//    var hours: [String: [String: String]] = ["":["":""]]
    
    init()
    {
        id = ""
        name = ""
    }
}
