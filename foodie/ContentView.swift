//
//  ContentView.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var groupManager: GroupManager
    @ObservedObject var swipeVar = SwipeVar()
    @State var addGroupToggle = false
    
    var body: some View {
        NavigationView {
            if !self.userDefaultsManager.userId.isEmpty {
                GeometryReader { g in
                    VStack {
                           GeometryReader { geometry in
                               ZStack {
                                HeaderView(addGroupToggle: self.$addGroupToggle)
                                    .offset(y: -geometry.size.height*0.44)
                                                           
                                BottomCard()
                                    .offset(y: -geometry.size.height*0.044)
                                   
                                CardStackView(swipeVar: self.swipeVar)
                                    .offset(y: -geometry.size.height*0.03)
                                                                 
                               Spacer()
                           
                               HStack {
                                DislikeButtonView(swipeVar: self.swipeVar)
                                   Spacer()
                                LikeButtonView(swipeVar: self.swipeVar)
                               }.offset(y:geometry.size.height*0.35)
                           }
                            
                            VStack {
                                Spacer()
                                FooterView()
                            }.padding(.bottom, 40)
                            
                       }
                    }
                    .onAppear(perform: {
                        if self.userDefaultsManager.email.isEmpty {
                            self.userManager.getUser(id: self.userDefaultsManager.userId)
                        }
                    })
                }
                .edgesIgnoringSafeArea(.top)
                .sheet(isPresented: self.$addGroupToggle) {
                    AddGroupView(addGroupToggle: self.$addGroupToggle)
                        .environmentObject(self.userDefaultsManager)
                        .environmentObject(self.groupManager)
                }
            } else {
                LoginView()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
