//
//  GroupView.swift
//  foodie
//
//  Created by Jae Hyun on 4/13/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @Binding var addToggle: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Groups")
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    self.addToggle.toggle()
                }) {
                    Image(systemName: "plus.circle")
                }
            }.padding(.horizontal, 15)
            
            ScrollView {
                ForEach(self.userDefaultsManager.groups) { group in
                    HStack {
                        Image("chicken")
                            .resizable()
                            .frame(width:60, height:60)
                            .cornerRadius(40)
                            
                        Spacer()
                        HStack {
                            VStack(alignment: .leading) {
                                Text(group.name)
                                Text(group.location)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "ellipsis")
                        }.padding(.leading, 5)
                    }.padding(.horizontal, 20)
                }
            }
        }
    }
}
