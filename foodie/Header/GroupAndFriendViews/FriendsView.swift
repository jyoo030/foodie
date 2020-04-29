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
            // Header
            HStack {
                Spacer()
                
                Text("Friends")
                    .font(.title)
                
                Spacer()
            }.padding(.horizontal, 15)
            
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
                        // Filtered list of names
                        ForEach(self.userDefaultsManager.friends.filter{($0.firstName + " " + $0.lastName).hasPrefix(searchText) || searchText == ""} ) { friend in
                            Text("\(friend.firstName)  \(friend.lastName)")
                        }
                    }
                    
                    Section(header: Text("Other users")) {
                        ForEach(self.userManager.searchResults) { friend in
                            VStack {
                                Text("\(friend.firstName)  \(friend.lastName)")
                                Text(friend.userName)
                                    .font(.subheadline)
                                    .accentColor(.gray)
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
            }
        }.padding(.horizontal, 10)
    }
}
