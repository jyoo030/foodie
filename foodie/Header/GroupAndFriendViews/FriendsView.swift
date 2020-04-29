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
    
    var body: some View {
        ScrollView {
            ForEach(self.userDefaultsManager.friends) { friend in
                HStack {
                    Image("chicken")
                        .resizable()
                        .frame(width:60, height:60)
                        .cornerRadius(40)
                        
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(friend.firstName) \(friend.lastName)")
                        }
                        Spacer()
                        Image(systemName: "ellipsis")
                    }.padding(.leading, 5)
                }.padding(.horizontal, 20)
            }
        }
    }
}
