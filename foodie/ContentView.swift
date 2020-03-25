//
//  ContentView.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var restaurants: [Restaurant] = [
        Restaurant(id: 0, name: "Pizza Hut", imageName: "pizza"),
        Restaurant(id: 1, name: "Taco Bell", imageName: "pizza"),
        Restaurant(id: 2, name: "Jack in the Box", imageName: "pizza"),
        Restaurant(id: 3, name: "Ten Rens", imageName: "pizza"),
        Restaurant(id: 4, name: "McDonalds", imageName: "pizza")
    ]
    @State  var yelpBusinessID: String = ""        

    var body: some View {
        NavigationView {
            VStack {
                   GeometryReader { geometry in
                       ZStack {
                        HeaderView().offset(y:-geometry.size.height*0.65)
                           
                        BottomCard()
                            .offset(y: -geometry.size.height*0.054)
                           
                        CardStackView(restaurants: self.$restaurants, yelpBusinessID: self.$yelpBusinessID)
                            .offset(y:-geometry.size.height*0.16)
                                 
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
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
