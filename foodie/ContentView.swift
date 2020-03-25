//
//  ContentView.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static var liked: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.move(edge: .trailing)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    static var disliked: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
        let removal = AnyTransition.move(edge: .leading)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct Restaurant: Hashable, CustomStringConvertible {
    var id: Int
    let name: String
    let imageName: String
    var description: String {
        return "\(name) id: \(id)"
    }
}

struct ContentView: View {
    @State var restaurants: [Restaurant] = [
        Restaurant(id: 0, name: "Pizza Hut", imageName: "pizza"),
        Restaurant(id: 1, name: "Taco Bell", imageName: "pizza"),
        Restaurant(id: 2, name: "Jack in the Box", imageName: "pizza"),
        Restaurant(id: 3, name: "Ten Rens", imageName: "pizza"),
        Restaurant(id: 4, name: "McDonalds", imageName: "pizza")
    ]
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(restaurants.count - 1 - id) * 10
           return geometry.size.width - offset
       }
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(restaurants.count - 1 - id) * 10 - geometry.size.height*0.25
    }
    
    private var maxID: Int {
        return self.restaurants.map { $0.id }.max() ?? 0
    }
        
    @State private var yelpBusinessID: String = ""

    var body: some View {
        NavigationView {
            VStack {
                   GeometryReader { geometry in
                       ZStack {
                           HeaderView().offset(y:-geometry.size.height*0.7)
                           
                           BottomCard()
                               .offset(y: -geometry.size.height*0.14)
                           
                           ForEach(self.restaurants, id: \.self) { restaurant in
                               Group {
                                    if restaurant.id > self.maxID - 4 {
                                        NavigationLink(destination: DetailView(yelpBusinessID: self.$yelpBusinessID))
                                            {
                                                CardView(restaurant: restaurant, onRemove: {
                                                    removedRestaurant in self.restaurants.removeAll { $0.id == removedRestaurant.id }
                                                })
                                                .frame(width: self.getCardWidth(geometry, id: restaurant.id), height: geometry.size.height)
                                                .offset(x: 0, y: self.getCardOffset(geometry, id: restaurant.id))
                                                .animation(.spring())
                                        }.buttonStyle(PlainButtonStyle())
                                   }
                               }
                           }
                       }.padding(.top, 80)
                                 
                       Spacer()
                   
                       HStack {
                           DislikeButtonView()
                           Spacer()
                           LikeButtonView()
                       }.offset(y:geometry.size.height*0.32)
                       
                       FooterView().offset(y:geometry.size.height*0.9)
                   }
               }
        }
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
