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
    var reciever: User = User()
    var message: String = ""
    
    init(dictionary: NSDictionary) {
           self.id = dictionary["_id"] as! String
           self.sender = User(dictionary: dictionary["sender"] as! NSDictionary)
           self.reciever = User(dictionary: dictionary["reciever"] as! NSDictionary)
           self.message = dictionary["message"] as! String
    }
    
    private enum CodingKeys: String, CodingKey{
        case id = "_id"
        case sender = "sender"
        case reciever = "reciever"
        case message = "message"
    }
}
