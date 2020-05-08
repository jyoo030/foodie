//
//  CurrentUserProfileView.swift
//  foodie
//
//  Created by Jae Hyun on 5/7/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { g in
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: {
                        self.userDefaultsManager.resetUserDefaults()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Log Out")
                    }
                }.padding(.horizontal, 20)
                
                Image("chicken")
                    .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(100)
                    .padding(.top, 20)
                
                VStack(spacing: 5) {
                    Text("\(self.userDefaultsManager.firstName) \(self.userDefaultsManager.lastName)")
                    Text("@\(self.userDefaultsManager.userName)")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                ScrollView {
                    Text("Put liked restaurants in this scrollview")
                }
            }
        }
        .navigationBarHidden(true)
        // Hacky solution i'm not proud of -jae
        // needed this to remove + button from friendsView
        .navigationBarItems(trailing: Text(""))
    }
}

//struct CurrentUserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentUserProfileView()
//    }
//}
