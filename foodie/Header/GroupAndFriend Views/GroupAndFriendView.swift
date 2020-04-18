//
//  GroupAndFriendView.swift
//  foodie
//
//  Created by Jae Hyun on 4/17/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct GroupAndFriendView: View {
    @State var currentView = "Groups"
    
    var body: some View {
        VStack(spacing: 0) {
            Text(currentView)
                .font(.title)
            
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
        }
    }
}

struct GroupAndFriendView_Previews: PreviewProvider {
    static var previews: some View {
        GroupAndFriendView()
    }
}
