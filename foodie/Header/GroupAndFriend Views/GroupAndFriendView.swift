//
//  GroupAndFriendView.swift
//  foodie
//
//  Created by Jae Hyun on 4/17/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct GroupAndFriendView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var groupManager: GroupManager
    
    @State var currentView = "Groups"
    @State var addToggle = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Spacer()
                
                Text(currentView)
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    self.addToggle.toggle()
                }) {
                    Image(systemName: "plus.circle")
                }
            }.padding(.horizontal, 15)
            
            if currentView == "Groups" {
                GroupsView()
            } else if currentView == "Friends" {
                FriendsView()
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.currentView = "Groups"
                }) {
                    Image(systemName: currentView == "Groups" ? "person.3.fill" : "person.3")
                        .resizable()
                        .frame(width: 35, height: 30)
                        .scaledToFit()
                }

                Spacer()
                
                Button(action: {
                    self.currentView = "Friends"
                }) {
                    Image(systemName: currentView == "Friends" ? "person.2.fill" : "person.2")
                        .resizable()
                        .frame(width: 35, height: 30)
                        .scaledToFit()
                }

                Spacer()
            }.padding(.vertical, 20)
        }.sheet(isPresented: $addToggle) {
            if self.currentView == "Groups" {
                AddGroupView(addGroupToggle: self.$addToggle)
                    .environmentObject(self.userDefaultsManager)
                    .environmentObject(self.groupManager)
            } else if self.currentView == "Friends" {
                
            }
        }
    }
}

struct GroupAndFriendView_Previews: PreviewProvider {
    static var previews: some View {
        GroupAndFriendView()
    }
}
