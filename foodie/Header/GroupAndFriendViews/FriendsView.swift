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
    @EnvironmentObject var userManager: UserManager
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
                    Section(header: Text("Friends")) {
                        ForEach(self.userDefaultsManager.friends.filter{($0.firstName + " " + $0.lastName).hasPrefix(searchText) || searchText == ""} ) { friend in
                            Text("\(friend.firstName)  \(friend.lastName)")
                        }
                    }
                    
                    Section(header: Text("Other Users")) {
                        ForEach(self.userManager.searchResults) { friend in
                            NavigationLink(destination: UserProfileView()) {
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
