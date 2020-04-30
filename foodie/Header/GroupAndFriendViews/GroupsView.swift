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
        .navigationBarTitle("Groups", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.addToggle.toggle()
            }) {
                Image(systemName: "plus.circle")
                    .colorInvert()
            }
        )
    }
}
