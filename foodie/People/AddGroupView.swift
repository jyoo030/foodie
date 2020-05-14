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
    
    @State private var selectedFriends: [User] = []
    @State var searchText: String = ""
    @State var highlightedFriend: User?
    @State var isEnabled: Bool = true

    @Binding var addGroupToggle: Bool
    
    func getFilteredFriendsList(searchText: String) -> [User] {
        if searchText.isEmpty {
            return self.userDefaultsManager.friends
        } else {
            return self.userDefaultsManager.friends.filter{"\($0.firstName) \($0.lastName) \($0.userName)".localizedCaseInsensitiveContains(searchText)}
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
                    var users = [self.userDefaultsManager.userId]
                    
                    for (friend) in self.selectedFriends {
                        users.append(friend.id)
                    }
                    
                    self.groupManager.createGroup(
                        name: self.groupName,
                        users: users,
                        admins: [self.userDefaultsManager.userId],
                        location: self.location,
                        radius: Int(self.mileRadius * 1600),
                        createdBy: self.userDefaultsManager.userId
                    )
                    
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
                                        
                    HStack {
                        ForEach(selectedFriends, id: \.self) { friend in
                            Button(action: {
                                if self.highlightedFriend == friend {
                                    self.highlightedFriend = nil
                                    self.isEnabled = true
                                } else {
                                    self.highlightedFriend = friend
                                    self.isEnabled = false
                                }
                            }) {
                                if(self.highlightedFriend == friend) {
                                    Text("\(friend.firstName) \(friend.lastName)")
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(4)
                                } else {
                                    Text("\(friend.firstName) \(friend.lastName)")
                                }
                            }
                        }
                        
                        SearchBar(placeholder: "Search", isEnabled: $isEnabled, text: $searchText, onBackspace: {
                            if self.selectedFriends.count > 0 {
                                if self.highlightedFriend == nil && self.searchText.count == 0 {
                                    self.highlightedFriend = self.selectedFriends.last!
                                    self.isEnabled = false
                                }
                                else if self.highlightedFriend != nil {
                                    self.selectedFriends.removeAll(where: { $0.id == self.highlightedFriend!.id })
                                    self.highlightedFriend = nil
                                    self.isEnabled = true
                                }
                            }
                        })
                        .disableAutocorrection(true)
                        .frame(height: 35)
                    }.foregroundColor(.primary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    
                    List(getFilteredFriendsList(searchText: self.searchText)) { friend in
                        Button(action: {
                            if self.selectedFriends.contains(friend) {
                                self.selectedFriends.removeAll(where: { $0.id == friend.id })
                            } else {
                                self.selectedFriends.append(friend)
                            }
                            self.searchText = ""
                        }) {
                            HStack {
                                Image("chicken")
                                    .resizable()
                                    .frame(width:40, height:40)
                                    .cornerRadius(40)
                                 
                                Text("\(friend.firstName) \(friend.lastName)").padding(.leading, 10)
                                
                                Spacer()
                                
                                if self.selectedFriends.contains(friend) {
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
