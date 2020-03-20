//
//  ContentView.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                HeaderView()
                    .offset(y:-300)
                
                BottomCard()
                    .offset(y: 140)
                
                CardView()
                    .offset(y: 50)
            }.padding(.top, 80)
                          
            Spacer()
            
            HStack {
                Spacer()
            
                DislikeButtonView()
                
                Spacer()
            
                LikeButtonView()
                
                Spacer()
            }.padding(.bottom, 10)
            
            FooterView()
                .padding(.bottom, 45)
        }
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
