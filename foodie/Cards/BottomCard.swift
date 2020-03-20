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
        ZStack {
            Text("No more cards 😢")
                .foregroundColor(Color.black)
                .font(.system(.largeTitle, design: .rounded))
            
            Rectangle()
               .foregroundColor(Color.gray)
                  .cornerRadius(20)
                   .opacity(0.4)
                   .frame(width: 340, height: 340)
        }.shadow(radius: 7)
    }
}

struct BottomCard_Previews: PreviewProvider {
    static var previews: some View {
        BottomCard()
    }
}
