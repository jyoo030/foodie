//
//  GroupAndFriendView.swift
//  foodie
//
//  Created by Jae Hyun on 4/17/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

enum PeopleEnum {
    case groups, friends, profile
}

struct PeopleView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var groupManager: GroupManager
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var currentView: PeopleEnum = .groups
    @State var addToggle = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            if currentView == PeopleEnum.groups {
                GroupsView(addToggle: self.$addToggle)
            } else if currentView == PeopleEnum.friends {
                FriendsView()
            } else if currentView == PeopleEnum.profile {
                CurrentUserProfileView()
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.currentView = PeopleEnum.groups
                }) {
                    Image(systemName: currentView == PeopleEnum.groups ? "person.3.fill" : "person.3")
                        .resizable()
                        .frame(width: 35, height: 30)
                        .scaledToFit()
                }

                Spacer()
                
                Button(action: {
                    self.currentView = PeopleEnum.friends
                }) {
                    Image(systemName: currentView == PeopleEnum.friends ? "person.2.fill" : "person.2")
                        .resizable()
                        .frame(width: 35, height: 30)
                        .scaledToFit()
                        .colorMultiply(self.notificationManager.recieved.filter{$0.message == "friend_request"}.count == 0 ? .white : .red)
                }

                Spacer()
                
                Button(action: {
                    self.currentView = PeopleEnum.profile
                }) {
                    Image(systemName: currentView == PeopleEnum.profile ? "person.fill" : "person")
                        .resizable()
                        .frame(width: 35, height: 30)
                        .scaledToFit()
                }
                
                Spacer()
            }.padding(.vertical, 10)
        }.sheet(isPresented: $addToggle) {
            if self.currentView == PeopleEnum.groups {
                AddGroupView(addGroupToggle: self.$addToggle)
                    .environmentObject(self.userDefaultsManager)
                    .environmentObject(self.groupManager)
            }
        }
    }
}
