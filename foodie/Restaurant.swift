//
//  Restaurant.swift
//  foodie
//
//  Created by Jae Hyun on 3/25/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct Restaurant: Hashable, CustomStringConvertible {
    var id: Int
    let name: String
    let imageName: String
    var description: String {
        return "\(name) id: \(id)"
    }
}
