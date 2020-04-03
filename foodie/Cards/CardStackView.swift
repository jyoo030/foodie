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
    @EnvironmentObject var networkingManager: NetworkingManager
    @Binding var toggle: likeOrDislike
    @Binding var pos: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(self.networkingManager.restaurants.enumeratedArray(), id: \.element.id) { index, item in
                    Group {
                        if index > (self.networkingManager.restaurants.count - 1) - self.numCards {
                            NavigationLink(destination: DetailView(restaurant: item)
                                .onAppear(perform: {
                                    self.networkingManager.getRestaurantsDetails(yelpID: item.id)
                                    self.networkingManager.getRestaurantReviews(yelpID: item.id)
                                }))
                             {
                                if !(index == self.networkingManager.restaurants.count-1 && self.toggle != .none) {
                                    CardView(restaurant: item, onRemove: { restaurant in
                                        self.networkingManager.onRemoveCard(restaurant: restaurant)
                                    })
                                        .frame(width: getCardWidth(geometry, index: index, length: self.networkingManager.restaurants.count), height: geometry.size.height)
                                        .offset(x:0, y: getCardOffset(geometry, index: index, length: self.networkingManager.restaurants.count))
                                        .animation(.spring())
                                        .transition(.move(edge: self.toggle == .like ? .trailing : .leading))
                                }
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
