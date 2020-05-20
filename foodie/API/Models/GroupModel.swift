//
//  Group.swift
//  foodie
//
//  Created by Jae Hyun on 4/13/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct GroupModel: Decodable, Encodable, Identifiable, Hashable {
    var id: String = ""
    var name: String = ""
    var users: [User] = []
    var likes: [String:[String]] = [:]
    var location: String = ""
    var radius: Int = 2000
    
    private enum CodingKeys: String, CodingKey{
        case id = "_id"
        case name = "name"
        case users = "users"
        case likes = "likes"
        case location = "location"
        case radius = "radius"
    }
}

struct PopulatedGroupModel: Decodable, Encodable, Identifiable, Hashable {
    var id: String = ""
    var name: String = ""
    var users: [String] = []
    var likes: [String:[String]] = [:]
    var location: String = ""
    var radius: Int = 2000
    
    private enum CodingKeys: String, CodingKey{
        case id = "_id"
        case name = "name"
        case users = "users"
        case likes = "likes"
        case location = "location"
        case radius = "radius"
    }
}
