//
//  CardStackView.swift
//  foodie
//
//  Created by Jae Hyun on 3/25/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

private func getCardWidth(_ geometry: GeometryProxy, id: Int, length: Int) -> CGFloat {
    let offset: CGFloat = CGFloat(length - 1 - id) * 10
       return geometry.size.width - offset
   }

private func getCardOffset(_ geometry: GeometryProxy, id: Int, length: Int) -> CGFloat {
    return  CGFloat(length - 1 - id) * 10
}

struct CardStackView: View {
    private var maxID: Int {
        return restaurants.map { $0.id }.max() ?? 0
    }
    
    @Binding var restaurants: [Restaurant]
    @Binding var yelpBusinessID: String

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(self.restaurants, id: \.self) { restaurant in
                    Group {
                         if restaurant.id > self.maxID - 4 {
                             NavigationLink(destination: DetailView(yelpBusinessID: self.$yelpBusinessID))
                             {
                                     CardView(restaurant: restaurant, onRemove: {
                                        removedRestaurant in self.restaurants.removeAll { $0.id == removedRestaurant.id }
                                     })
                                        .frame(width: getCardWidth(geometry, id: restaurant.id, length: self.restaurants.count), height: geometry.size.height)
                                        .offset(x: 0, y: getCardOffset(geometry, id: restaurant.id, length: self.restaurants.count))
                                     .animation(.spring())
                             }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView(restaurants: .constant(
            [Restaurant(id: 0, name: "Pizza Hut", imageName: "pizza"),
             Restaurant(id: 0, name: "Pizza Hut", imageName: "pizza")]), yelpBusinessID: .constant(""))
    }
}
