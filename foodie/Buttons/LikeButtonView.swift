//
//  LikeButtonView.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
// ? is optional and can be null
// ! unwraps

import SwiftUI

struct LikeButtonView: View {
    @EnvironmentObject var networkingManager: NetworkingManager
    @Binding var toggle: likeOrDislike
    @Binding var pos: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Button(
              action: {
                withAnimation{
                    self.toggle = .like
                    self.pos = 100
                }
                self.pos = 0
                self.networkingManager.onRemoveCard(restaurant: self.networkingManager.restaurants.last!)
                self.toggle = .none
              },
              label: { Image("like_button").renderingMode(.original)
                  .resizable()
                  .frame(width: geometry.size.width*0.2, height: geometry.size.width*0.2)
                  .aspectRatio(contentMode: .fit)
                  .padding(10)
              }
            )
            .background(Color.white)
            .clipShape(Circle())
            .frame(width: geometry.size.width*0.2, height: geometry.size.width*0.2)
            .shadow(radius: 7)
        }

    }
}

//struct LikeButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikeButtonView()
//    }
//}
