//
//  BottomCard.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct BottomCard: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("No more cards 😢")
                    .foregroundColor(Color.black)
                    .font(.system(.largeTitle, design: .rounded))
                
                Rectangle()
                   .foregroundColor(Color.gray)
                      .cornerRadius(20)
                       .opacity(0.4)
                       .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.55)
            }.shadow(radius: 7)
        }
    }
}

struct BottomCard_Previews: PreviewProvider {
    static var previews: some View {
        BottomCard()
    }
}
