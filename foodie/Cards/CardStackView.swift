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

struct CardStackView: View {
    @EnvironmentObject var networkingManager: NetworkingManager
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(self.networkingManager.restaurants.indices, id: \.self) { index in
                    Group {
                        if index > self.networkingManager.restaurants.count - 3 {
                            NavigationLink(destination: DetailView(yelpBusinessID: self.networkingManager.restaurants[index].id))
                             {
                                CardView(restaurant: self.networkingManager.restaurants[index], onRemove: { removedUser in
                                    self.networkingManager.restaurants.removeAll { $0.id == removedUser.id }
                                })
                                    .frame(width: getCardWidth(geometry, index: index, length: self.networkingManager.restaurants.count), height: geometry.size.height)
                                    .offset(x: 0, y: getCardOffset(geometry, index: index, length: self.networkingManager.restaurants.count))
                                     .animation(.spring())
                             }.buttonStyle(PlainButtonStyle())
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
