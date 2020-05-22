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
    
    @Published var currentGroup: GroupModel = try! JSONDecoder().decode(GroupModel.self,
        from: (UserDefaults.standard.object(forKey: "currentGroup") ?? JSONEncoder().encode(GroupModel())) as! Data) {
        didSet {
            let encoded = try? JSONEncoder().encode(self.currentGroup)
            UserDefaults.standard.set(encoded, forKey: "currentGroup")
        }
    }
    
    @Published var firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? "" {
        didSet { UserDefaults.standard.set(self.firstName, forKey: "firstName") }
    }
    
    @Published var lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? "" {
        didSet { UserDefaults.standard.set(self.lastName, forKey: "lastName") }
    }
    
    @Published var userName: String = UserDefaults.standard.string(forKey: "userName") ?? "" {
        didSet { UserDefaults.standard.set(self.userName, forKey: "userName") }
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
    
    func resetUserDefaults() {
        self.userId = ""
        self.currentGroup = GroupModel()
        self.firstName = ""
        self.lastName = ""
        self.userName = ""
        self.email = ""
        self.groups = []
        self.friends = []
    }
}
