//
//  DislikeButtonView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct DislikeButtonView: View {
    @EnvironmentObject var networkingManager: NetworkingManager
    @Binding var toggle: CGFloat
    @Binding var degree: Double

    var body: some View {
        GeometryReader { geometry in
            Button(
                action: {
                    withAnimation(.easeOut(duration: 0.15)){
                        self.degree = -10
                        self.toggle = -500
                  }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.degree = 0
                        self.toggle = 0
                        self.networkingManager.onRemoveCard(restaurant: self.networkingManager.restaurants.last!)
                    }
                },
                label: { Image("dislike_button").renderingMode(.original)
                    .resizable()
                    .frame(width: geometry.size.width*0.2, height: geometry.size.width*0.2)
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                }
            )
            .background(Color.white)
                .clipShape(Circle())
            .frame(width: geometry.size.width*0.15, height: geometry.size.width*0.15)
            .shadow(radius: 7)
        }
    }
}

//struct DislikeButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        DislikeButtonView()
//    }
//}
