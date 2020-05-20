//
//  DislikeButtonView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct DislikeButtonView: View {
    @EnvironmentObject var restaurantManager: RestaurantManager
    @EnvironmentObject var socket: Socket
    @ObservedObject var swipeVar: SwipeVar = SwipeVar()

    var body: some View {
        Button(
            action: {
                if !self.restaurantManager.restaurants.isEmpty {
                    self.swipeVar.status = .nah

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(Animation.easeOut(duration: 0.15)) {
                            self.swipeVar.degree = -10
                            self.swipeVar.toggle = -500
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.swipeVar.degree = 0
                        self.swipeVar.toggle = 0
                        self.swipeVar.status = .none
                        self.socket.like(restaurantId: self.restaurantManager.restaurants.last!.id)
//                        self.restaurantManager.onRemoveCard(restaurant: self.restaurantManager.restaurants.last!)
                    }
                }
            },
            label: { Image("dislike_button").renderingMode(.original)
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
                .padding(10)
            }
        )
        .background(Color.white)
            .clipShape(Circle())
        .shadow(radius: 7)
    }
}

struct DislikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DislikeButtonView()
    }
}
