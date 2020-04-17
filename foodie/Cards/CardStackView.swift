//
//  CardStackView.swift
//  foodie
//
//  Created by Jae Hyun on 3/25/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

private func getCardWidth(_ geometry: GeometryProxy, index: Int, length: Int) -> CGFloat {
    let offset: CGFloat = CGFloat(length - 1 - index) * 10
       return geometry.size.width - offset
   }

private func getCardOffset(_ geometry: GeometryProxy, index: Int, length: Int) -> CGFloat {
    return  CGFloat(length - 1 - index) * 10
}

extension Collection {
  func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
    return Array(self.enumerated())
  }
}

struct CardStackView: View {
    var numCards = 2
    @EnvironmentObject var restaurantManager: RestaurantManager
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @ObservedObject var swipeVar: SwipeVar
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                ForEach(self.restaurantManager.restaurants.enumeratedArray(), id: \.element.id) { index, item in
                    Group {
                        if index > (self.restaurantManager.restaurants.count - 1) - self.numCards {
                            NavigationLink(destination: DetailView(restaurant: item)
                                .onAppear(perform: {
                                    self.restaurantManager.getRestaurantsDetails(yelpID: item.id)
                                    self.restaurantManager.getRestaurantReviews(yelpID: item.id)
                                }))
                             {
                                CardView(restaurant: item, index: index, swipeVar: self.swipeVar, onRemove: { restaurant in
                                    self.restaurantManager.onRemoveCard(restaurant: restaurant)
                                })
                                    .frame(width: getCardWidth(geometry, index: index, length: self.restaurantManager.restaurants.count))
                                    .offset(x: self.restaurantManager.isLastCard(index: index) ? self.swipeVar.toggle : 0, y: getCardOffset(geometry, index: index, length: self.restaurantManager.restaurants.count))
                                    .animation(.spring())
                                    .rotationEffect(.degrees(self.restaurantManager.isLastCard(index: index) ? self.swipeVar.degree : 0))
                             }
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
    }
}
//
//struct CardStackView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardStackView(restaurants: .constant(
//            [Restaurant]), yelpBusinessID: .constant(""))
//    }
//}
