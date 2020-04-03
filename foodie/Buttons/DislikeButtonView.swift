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
    @Binding var toggle: likeOrDislike
    @Binding var pos: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Button(
                action: {
                  withAnimation(.easeIn(duration: 1)){
                      self.toggle = .dislike
                      self.pos = -100
                  }
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      self.networkingManager.onRemoveCard(restaurant: self.networkingManager.restaurants.last!)
                      self.toggle = .none
                      self.pos = 0
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
