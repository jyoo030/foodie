//
//  ContentView.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkingManager: NetworkingManager
    @State var toggle: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                   GeometryReader { geometry in
                       ZStack {
                        HeaderView().offset(y:-geometry.size.height*0.65)
                                                   
                        BottomCard()
                            .offset(y: -geometry.size.height*0.054)
                           
                        CardStackView(toggle: self.$toggle)
                            .offset(y:-geometry.size.height*0.16)
                                                         
                       Spacer()
                   
                       HStack {
                        DislikeButtonView(toggle: self.$toggle)
                           Spacer()
                        LikeButtonView(toggle: self.$toggle)
                       }.offset(y:geometry.size.height*0.32)
                       
                       FooterView().offset(y:geometry.size.height*0.9)
                   }
               }
            }
            .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
