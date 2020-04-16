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
                    let friendsArray: [String] = self.friends.components(separatedBy: ", ")
                    var friendsIdArray: [String:String] = [:]
                    for friendName in friendsArray {
                        let friendId = self.userDefaultsManager.getIdFromName(name: friendName)
                        if friendId == "" {
                            self.nameError = friendName
                        } else {
                            friendsIdArray[friendName] = friendId
                        }
                    }
                    
                    print(friendsArray)
                    print(friendsIdArray)
                    
                    if self.nameError.isEmpty {
                        var users = [self.userDefaultsManager.userId]
                        
                        for (_,item) in friendsIdArray {
                            users.append(item)
                        }
                        
                        self.groupManager.createGroup(
                            name: self.groupName,
                            users: users,
                            admins: [self.userDefaultsManager.userId], createdBy: self.userDefaultsManager.userId)
                    }
                }) {
                    Text("Create")
                }
            }
            Spacer()
        }
    }

}
