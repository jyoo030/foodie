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
    @ObservedObject var swipeVar: SwipeVar = SwipeVar()

    var body: some View {
        GeometryReader { geometry in
            Button(
                action: {
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
                        self.restaurantManager.onRemoveCard(restaurant: self.restaurantManager.restaurants.last!)
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
