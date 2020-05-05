//
//  NotificationObject.swift
//  foodie
//
//  Created by Jae Hyun on 5/3/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

struct NotificationModel: Decodable, Encodable, Hashable {
    var id: String = ""
    var sender: User = User()
    var reciever: String = ""
    var message: String = ""
    
    private enum CodingKeys: String, CodingKey{
        case id = "_id"
        case sender = "sender"
        case reciever = "reciever"
        case message = "message"
    }
}
