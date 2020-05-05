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
    @EnvironmentObject var notificationManager: NotificationManager
    @ObservedObject var swipeVar = SwipeVar()
    @State var addGroupToggle = false
    
    // Remove tint from NavigationBar
    // TODO move to some delegate
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        appearance.largeTitleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some View {
        NavigationView {
            if !self.userDefaultsManager.userId.isEmpty {
                GeometryReader { g in
                    ZStack {
                        BottomCard()
                            .offset(y: -g.size.height*0.044)

                        CardStackView(swipeVar: self.swipeVar)
                            .offset(y: -g.size.height*0.015)
                    }

                        VStack {
                            Spacer()

                            HStack {
                                 DislikeButtonView(swipeVar: self.swipeVar)
                                 Spacer()
                                 LikeButtonView(swipeVar: self.swipeVar)
                            }.padding(.horizontal, 50)
                        }
                            
                    .navigationBarItems(leading:
                        NavigationLink(destination: GroupAndFriendView()) {
                        Image(systemName: "person.3.fill").renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: g.size.width*0.11, height: g.size.width*0.11)
                            .colorInvert()
                            .colorMultiply(self.notificationManager.recieved.filter{$0.message == "friend_request"}.count == 0 ? .gray : .red)
                    }, trailing:
                        Button(action: {
                                self.addGroupToggle = true
                        }) {
                            Image(systemName: "plus.circle.fill").renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: g.size.width*0.08, height: g.size.width*0.08)
                                .colorInvert()
                                .colorMultiply(.gray)

                        }
                    )
                    .navigationBarTitle(Text(self.userDefaultsManager.currentGroup.name), displayMode: .inline)
                    .onAppear(perform: {
                        self.notificationManager.getNotifications(userId: self.userDefaultsManager.userId)

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
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
