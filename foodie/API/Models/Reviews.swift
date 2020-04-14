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

struct Review: Decodable, Identifiable {
    var id: String = ""
    var rating: Float = 0.0
    var user: ReviewUser = ReviewUser()
    var text: String = ""
    var url: String = ""
    var time_created: String = ""
}

struct ReviewUser: Decodable {
    var id: String = ""
    var profile_url: String = ""
    var image_url: String? = ""
    var name: String = ""
}
