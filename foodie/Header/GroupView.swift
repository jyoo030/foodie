//
//  GroupView.swift
//  foodie
//
//  Created by Jae Hyun on 4/13/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    var body: some View {
        VStack {
            HStack {
                Text(userDefaultsManager.groups.isEmpty ? "No Groups :(" : userDefaultsManager.groups[0].name)
                    .foregroundColor(Color.white)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()               
            }
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
