//
//  HeaderView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    func getCurrentGroup() -> String {
        let currentGroup = self.userDefaultsManager.groups.first(where: {$0.id == self.userDefaultsManager.currentGroup.id})
        return currentGroup == nil ? "No Groups" : currentGroup!.name
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color(red: 247/255, green: 114/255, blue: 203/255, opacity: 0.7))
                    .frame(width: geometry.size.width * 1.3)
                
                 HStack {
                    NavigationLink(destination: GroupAndFriendView()) {
                        Image(systemName: "person.3").renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width*0.11, height: geometry.size.width*0.11)
                        .colorInvert()
                    }

                    
                    Spacer()
                    
                    Text(self.getCurrentGroup())
                        .foregroundColor(Color.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()

                    
                    Spacer()
                    
                    NavigationLink(destination: AddGroupView()) {
                        Image(systemName: "plus.circle").renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width*0.08, height: geometry.size.width*0.08)
                        .colorInvert()
                    }
                 }
                    .padding(.horizontal, 20)
                 .frame(width: geometry.size.width)
                .offset(y:geometry.size.height*0.06)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
