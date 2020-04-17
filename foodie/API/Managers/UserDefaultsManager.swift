//
//  UserDefaultsManager.swift
//  foodie
//
//  Created by Jae Hyun on 4/11/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserDefaultsManager : ObservableObject {
    @Published var userId: String = UserDefaults.standard.string(forKey: "userId") ?? "" {
        didSet { UserDefaults.standard.set(self.userId, forKey: "userId") }
    }
    
    @Published var currentGroup: PopulatedGroupModel = try! JSONDecoder().decode(PopulatedGroupModel.self,
        from: (UserDefaults.standard.object(forKey: "currentGroup") ?? JSONEncoder().encode(PopulatedGroupModel())) as! Data) {
        didSet {
            let encoded = try? JSONEncoder().encode(self.currentGroup)
            UserDefaults.standard.set(encoded, forKey: "currentGroup")
        }
    }
    
    @Published var name: String = UserDefaults.standard.string(forKey: "name") ?? "" {
        didSet { UserDefaults.standard.set(self.name, forKey: "name") }
    }
    
    @Published var email: String = UserDefaults.standard.string(forKey: "email") ?? "" {
        didSet { UserDefaults.standard.set(self.email, forKey: "email") }
    }
    
    @Published var groups: [GroupModel] = try! JSONDecoder().decode([GroupModel].self,
        from: (UserDefaults.standard.object(forKey: "groups") ?? JSONEncoder().encode([GroupModel()])) as! Data) {
        didSet {
            let encoded = try? JSONEncoder().encode(self.groups)
            UserDefaults.standard.set(encoded, forKey: "groups")
        }
    }
    
    @Published var friends: [User] = try! JSONDecoder().decode([User].self,
        from: (UserDefaults.standard.object(forKey: "friends") ?? JSONEncoder().encode([User()])) as! Data) {
        didSet {
            let encoded = try? JSONEncoder().encode(self.friends)
            UserDefaults.standard.set(encoded, forKey: "friends")
        }
    }
    
    func getIdFromName(name: String) -> String {
        let friend = self.friends.filter{ $0.name.lowercased() == name.lowercased() }.first
        return friend == nil ? "" : friend!.id
    }
}
