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
    
    var body: some View {
        NavigationView {
            if !self.userDefaultsManager.userId.isEmpty {
                VStack {
                       GeometryReader { geometry in
                           ZStack {
                            HeaderView().offset(y:-geometry.size.height*0.65)
                                                       
                            BottomCard()
                                .offset(y: -geometry.size.height*0.054)
                               
                            CardStackView(swipeVar: self.swipeVar)
                                .offset(y:-geometry.size.height*0.16)
                                                             
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
                        }
                        
                   }
                }
                .onAppear(perform: {
                    self.userManager.getUser(id: self.userDefaultsManager.userId)
                })
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
            } else {
                LoginView()
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
