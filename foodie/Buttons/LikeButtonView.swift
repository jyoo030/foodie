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
    @EnvironmentObject var restaurantManager: RestaurantManager
    @EnvironmentObject var socket: Socket
    @ObservedObject var swipeVar: SwipeVar = SwipeVar()
    
    @State var isDisabled = false

    var body: some View {
        Button(
          action: {
            if !self.isDisabled {
                self.isDisabled = true
                
                if !self.restaurantManager.restaurants.isEmpty {
                    self.swipeVar.status = .yum
                    
                    // Initial delay after pressing button
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(Animation.easeOut(duration: 0.15)) {
                            self.swipeVar.degree = 10
                            self.swipeVar.toggle = 500
                        }
                    }
                    
                    // Delay for card to leave screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.swipeVar.degree = 0
                        self.swipeVar.toggle = 0
                        self.swipeVar.status = .none
                        
                        self.socket.like(restaurantId: self.restaurantManager.restaurants.last!.id)
                        self.restaurantManager.onRemoveCard( restaurant: self.restaurantManager.restaurants.last!)
                    }
                }
                
                // Delay for presses between buttons
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isDisabled = false
                }
            }
          },
          label: { Image("like_button").renderingMode(.original)
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

struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView()
    }
}
