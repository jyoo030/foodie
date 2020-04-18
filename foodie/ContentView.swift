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
    @ObservedObject var swipeVar = SwipeVar()
    @State var addGroupToggle = false
    
    var body: some View {
        NavigationView {
            if !self.userDefaultsManager.userId.isEmpty {
                ZStack {
                    VStack {
                           GeometryReader { geometry in
                               ZStack {
                                HeaderView(addGroupToggle: self.$addGroupToggle).offset(y:-geometry.size.height*0.53)
                                                           
                                BottomCard()
                                    .offset(y: -geometry.size.height*0.054)
                                   
                                CardStackView(swipeVar: self.swipeVar)
                                    .offset(y:-geometry.size.height*0.1)
                                                                 
                               Spacer()
                           
                               HStack {
                                DislikeButtonView(swipeVar: self.swipeVar)
                                   Spacer()
                                LikeButtonView(swipeVar: self.swipeVar)
                               }.offset(y:geometry.size.height*0.32)
                           }
                            
                            VStack {
                                Spacer()
                                FooterView()
                            }.padding(.bottom, 40)
                            
                       }
                    }
                    .zIndex(0)
                    .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                    .onAppear(perform: {
                        if self.userDefaultsManager.name.isEmpty {
                            self.userManager.getUser(id: self.userDefaultsManager.userId)
                        }
                    })
                    
                    if self.addGroupToggle {
                        AddGroupView(addGroupToggle: self.$addGroupToggle)
                            .zIndex(1)
                            .transition(.move(edge: .bottom))
                    }
                }
            } else {
                LoginView()
            }
        }.edgesIgnoringSafeArea(.top)
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
