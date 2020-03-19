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
                
                // Dislike Button
                Button(
                    action: {
                        // do something
                    },
                    label: { Image("dislike_button").renderingMode(.original)
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                    }
                )
                .background(Color.white)
                    .clipShape(Circle())
                .frame(width: 60.0, height: 60.0)
                .shadow(radius: 7)
                
                Spacer()
            
                // Like Button
                Button(
                    action: {
                        // do something
                    },
                    label: { Image("like_button").renderingMode(.original)
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                    }
                )
                .background(Color.white)
                .clipShape(Circle())
                .frame(width: 60.0, height: 60.0)
                .shadow(radius: 7)
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
