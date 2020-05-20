//
//  FriendsView.swift
//  foodie
//
//  Created by Jae Hyun on 4/17/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct FriendsView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var socket: Socket
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        VStack {
            // Search Bar
            VStack {
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            self.userManager.searchUsers(searchText: self.searchText)
                        }).foregroundColor(.primary)

                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)


                }
                .padding(.horizontal)

                List {
                    if self.notificationManager.recieved.count > 0 {
                        Section(header: Text("Friend Requests")) {
                            ForEach(self.notificationManager.recieved.filter{$0.reciever.id == self.userDefaultsManager.userId}, id: \.self) {request in
                                HStack {
                                    Text("\(request.sender.firstName) \(request.sender.lastName)")

                                    Spacer()
                                    
                                    Button(action: {
                                        self.socket.friendRequestResponse(notificationId: request.id, accept: true) { notification in
                                            self.userDefaultsManager.friends.append(notification.sender)
                                            self.notificationManager.recieved.removeAll{$0.id == notification.id}
                                        }
                                    }) {
                                        Image(systemName: "checkmark.circle")
                                    }.buttonStyle(BorderlessButtonStyle())

                                    Button(action: {
                                        self.socket.friendRequestResponse(notificationId: request.id, accept: false) { notification in
                                            self.notificationManager.recieved.removeAll{$0.id == notification.id}
                                        }
                                    }) {
                                        Image(systemName: "x.circle")
                                    }.buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                    }
                
                    Section(header: Text("Friends")) {
                        ForEach(self.userDefaultsManager.friends.filter{($0.firstName + " " + $0.lastName + " " + $0.userName).contains(searchText) ||
                            searchText == ""}) { friend in
                            NavigationLink(destination: UserProfileView(user: friend)) {
                                HStack {
                                    Image("chicken")
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(30)
                                        .padding(.horizontal, 10)
                                        .scaledToFill()
                                
                                    VStack(alignment: .leading) {
                                        Text("\(friend.firstName)  \(friend.lastName)")
                                        Text("@\(friend.userName)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    if self.userManager.searchResults.count > 0 {
                        Section(header: Text("Other Users")) {
                            ForEach(self.userManager.searchResults.filter{!self.userDefaultsManager.friends.contains($0)}) { friend in
                                NavigationLink(destination: UserProfileView(user: friend)) {
                                    HStack {
                                        Image("chicken")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(30)
                                            .padding(.horizontal, 10)
                                            .scaledToFill()
                                    
                                        VStack(alignment: .leading) {
                                            Text("\(friend.firstName)  \(friend.lastName)")
                                            Text("@\(friend.userName)")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
            }
        }
        .padding(.horizontal, 10)
        .navigationBarTitle("Friends", displayMode: .inline)
            // Hacky solution i'm not proud of -jae
            // needed this to remove + button from friendsView
        .navigationBarItems(trailing: Text(""))
    }
}
