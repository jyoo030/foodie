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
                GeometryReader { g in
                    ZStack {
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
                        .zIndex(0)
                        .background(self.addGroupToggle ? Color.gray : Color(red: 240/255, green: 240/255, blue: 240/255))
                        .cornerRadius(self.addGroupToggle ? 30 : 0)
                        .scaleEffect(x: self.addGroupToggle ? 0.95 : 1, y: self.addGroupToggle ? 0.95 : 1, anchor: .center)
                        .frame(height: self.addGroupToggle ? g.size.height * 0.87 : g.size.height)
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
                }
                .edgesIgnoringSafeArea(.top)
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
