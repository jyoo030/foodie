//
//  User.swift
//  foodie
//
//  Created by Jae Hyun on 4/13/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct User: Decodable {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var groups: [String] = []
    var friends: [String] = []
    
    private enum CodingKeys: String, CodingKey{
        case id = "_id"
        case name = "name"
        case email = "email"
        case groups = "groups"
        case friends = "friends"
    }
}
