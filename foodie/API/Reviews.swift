//
//  File.swift
//  foodie
//
//  Created by Jae Hyun on 4/1/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    var reviews: [Review]
}

struct Review: Decodable {
    var id: String = ""
    var rating: Float = 0.0
    var user: User = User()
    var text: String = ""
    var url: String = ""
}

struct User: Decodable {
    var id: String = ""
    var profile_url: String = ""
    var image_url: String? = ""
    var name: String = ""
}
