//
//  Response.swift
//  foodie
//
//  Created by Jae Hyun on 4/11/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct Response: Decodable {
    var errors: [String]?
    var userId: String?
    var group: GroupModel?
}
