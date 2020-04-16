//
//  Group.swift
//  foodie
//
//  Created by Jae Hyun on 4/13/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct GroupModel: Decodable, Encodable, Identifiable {
    var id: String = ""
    var name: String = ""
    var users: [User] = []
    var likes: [String:String] = [:]
    
    private enum CodingKeys: String, CodingKey{
        case id = "_id"
        case name = "name"
        case users = "users"
        case likes = "likes"
    }
}
