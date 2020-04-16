//
//  AddGroupView.swift
//  foodie
//
//  Created by Jae Hyun on 4/15/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct AddGroupView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var groupManager: GroupManager
    @State private var groupName: String = ""
    @State private var friends: String = ""
    @State private var location: String = "riverside, ca"
    @State private var radius: String = "2000"
    @State private var nameError: String = ""

    func parseFriends() -> [String:String] {
        let friendsArray: [String] = self.friends.components(separatedBy: ", ")
        var friendsIdDict: [String:String] = [:]
        for friendName in friendsArray {
            let friendId = self.userDefaultsManager.getIdFromName(name: friendName)
            if friendId == "" {
                self.nameError = friendName
            } else {
                friendsIdDict[friendName] = friendId
            }
        }
        return friendsIdDict
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if !nameError.isEmpty {
                    Text("\(self.nameError) is not on your friends list")
                }
                TextField("Group Name", text: $groupName)
                TextField("Add Friends", text: $friends)
                TextField("Location", text: $location)
                TextField("Radius", text: $radius)
                Button(action: {
                    let friendIdDict = self.parseFriends()
                    
                    if self.nameError.isEmpty {
                        var users = [self.userDefaultsManager.userId]
                        
                        for (_,item) in friendIdDict {
                            users.append(item)
                        }
                        
                        self.groupManager.createGroup(
                            name: self.groupName,
                            users: users,
                            admins: [self.userDefaultsManager.userId], createdBy: self.userDefaultsManager.userId
                        )
                    }
                }) {
                    Text("Create")
                }
            }
            Spacer()
        }
    }

}
