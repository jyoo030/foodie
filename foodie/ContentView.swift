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
            Spacer()
            HStack {
                Spacer()
            
                DislikeButtonView()
                
                Spacer()
            
                LikeButtonView()
                
                Spacer()
            }
        }
        .padding(.bottom, 100)
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
