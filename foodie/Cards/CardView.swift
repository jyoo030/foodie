//
//  CardView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("pizza")
            .resizable()
                .frame(width: 380, height: 380)
            
            ZStack {
                Rectangle()
                    .frame(width: 380, height: 100)
                    .foregroundColor(Color.white)

                VStack{
                    HStack{
                        Text("Pizza Hut")
                        .foregroundColor(Color.black)
                        .font(.system(.largeTitle, design: .rounded))
                        .multilineTextAlignment(.leading)
                    }
                }
            }
        }
            
        .cornerRadius(20)
        .padding(.horizontal, 20)
            .shadow(radius:7)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
