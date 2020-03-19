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
                        .aspectRatio(contentMode: .fit)
                    }
                )
                .frame(width: 50.0, height: 50.0)
                
                Spacer()
            
                // Like Button
                Button(
                    action: {
                        // do something
                    },
                    label: { Image("like_button").renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }
                )
                .frame(width: 50.0, height: 50.0)
                Spacer()
            }
        }.padding(.bottom, 50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
