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
            List(self.userDefaultsManager.groups) { group in
                Text(group.name)
            }
        }.navigationBarTitle(Text("Groups"))
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
