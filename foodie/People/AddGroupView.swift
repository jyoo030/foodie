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
    @State private var location: String = ""
    @State private var mileRadius: Float = 5
    @State private var nameError: String = ""
    
    @State private var selectedFriends: [String] = []
    @State private var previousSearchText: String = ""
    @State private var currentSearchText: String = ""

    @Binding var addGroupToggle: Bool

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
    
    func getSearchText() {
        self.previousSearchText = ""
        
        for name in selectedFriends {
            self.previousSearchText += "\(name), "
        }
    }
    
    var body: some View {
        VStack() {
            HStack {
                Button(action: {
                    self.addGroupToggle = false
                }) {
                    Text("Cancel")
                }
                
                Spacer()
                
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
                            admins: [self.userDefaultsManager.userId],
                            location: self.location,
                            radius: Int(self.mileRadius * 1600),
                            createdBy: self.userDefaultsManager.userId
                        )
                    }
                    
                    self.addGroupToggle = false
                }) {
                    Text("Create")
                }
            }
            .padding(.horizontal, 15)
            
                            
            VStack(alignment: .center) {
                
                Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                    .colorInvert()
                    .colorMultiply(.gray)
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 3)
                    .frame(width: 70, height: 70)

                ).padding(.vertical, 20)
                
                TextField("Group Name", text: self.$groupName)
                    .font(.headline)
                    .multilineTextAlignment(.center)

                TextField("Location", text: self.$location)
                    .multilineTextAlignment(.center)

                VStack() {
                    HStack {
                        Text("Radius")
                        Spacer()
                        Text("\(self.mileRadius, specifier: "%.1f")mi.")
                    }
                    
                    Slider(value: self.$mileRadius, in: 1...25, step: 0.1)
                                        
                    TextField("search", text: $previousSearchText)
                        .foregroundColor(.primary)
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                    
                    
                    List(self.userDefaultsManager.friends) { friend in
                        Button(action: {
                            if self.selectedFriends.contains(friend.firstName) {
                                self.selectedFriends.remove(at: self.selectedFriends.firstIndex(of: friend.firstName)!)
                            } else {
                                self.selectedFriends.append(friend.firstName)
                            }
                            
                            self.getSearchText()

                        }) {
                            HStack {
                                Image("chicken")
                                    .resizable()
                                    .frame(width:40, height:40)
                                    .cornerRadius(40)
                                 
                                Text(friend.firstName).padding(.leading, 10)
                                
                                Spacer()
                                
                                if self.selectedFriends.contains(friend.firstName) {
                                    Image(systemName: "checkmark.circle")
                                } else {
                                    Image(systemName: "ellipsis")
                                }
                            }
                        }
                    }
                    
                }
            }
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 10)
        .background(Color.white)
    }

}
