//
//  User.swift
//  foodie
//
//  Created by Jae Hyun on 4/13/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct User: Hashable, Decodable, Encodable, Identifiable {
    static func == (lhs: User, rhs: User) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userName)
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(email)
        hasher.combine(groups)
        hasher.combine(friends)
        hasher.combine(currentGroup)
    }
    
    var id: String = ""
    var userName: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var groups: [GroupModel]?
    var friends: [User]?
    var currentGroup: PopulatedGroupModel?
    
    private enum CodingKeys: String, CodingKey{
        case id = "_id"
        case userName = "userName"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case groups = "groups"
        case friends = "friends"
        case currentGroup = "currentGroup"
    }
}
