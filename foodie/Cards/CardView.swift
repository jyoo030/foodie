//
//  CardView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//
//
import SwiftUI
import KingfisherSwiftUI

enum yumOrNah: Int {
    case yum, nah, none
}

struct CardView: View {
    private var onRemove: (_ Restaurant: Restaurant) -> Void
    private var restaurant: Restaurant
    var thresholdPercentage: CGFloat = 0.3
    var index: Int
    @State private var translation: CGSize = .zero
    @ObservedObject var swipeVar: SwipeVar
    @EnvironmentObject var socket: Socket

    @EnvironmentObject var restaurantManager: RestaurantManager
    
    init(restaurant: Restaurant, index: Int, swipeVar: SwipeVar, onRemove: @escaping (_ Restaurant: Restaurant) -> Void) {
        self.restaurant = restaurant
        self.swipeVar = swipeVar
        self.index = index
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
           gesture.translation.width / geometry.size.width
       }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                KFImage(URL(string: self.restaurant.image_url)!)
                .resizable()
                    .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width * 0.98, height: geometry.size.height * 0.75)

                VStack {
                    HStack {
                        if self.restaurantManager.isLastCard(index: self.index) {
                            if self.swipeVar.status == .yum {
                                YummyView()
                            }
                            Spacer()
                            if self.swipeVar.status == .nah {
                                NahView()
                            }
                        }
                    }

                    Spacer()
                }
                
                VStack {
                    Spacer()


                    VStack {
                        HStack {
                            Text(self.restaurant.name)
                                .font(.system(size: geometry.size.width * 0.058))
                                .foregroundColor(.white)
                                .bold()
                            
                            Spacer()

                            Text(self.restaurant.price ?? "")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            RatingView(rating: Float(self.restaurant.rating))
                            
                            Spacer()

                            Text(String(self.restaurant.review_count) + " Reviews")
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width * 0.95)
                }.padding()
            }
            .frame(width: geometry.size.width * 0.98, height: geometry.size.height * 0.75)
            .cornerRadius(20)
            .padding(.horizontal, 20)
                .shadow(radius:7)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: self.translation.height)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
                .contentShape(Rectangle())
            .gesture(
                 DragGesture()
                 .onChanged { value in
                     self.translation = value.translation
                    if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                        self.swipeVar.status = .yum
                    } else if (self.getGesturePercentage(geometry, from: value)) <= -self.thresholdPercentage {
                        self.swipeVar.status = .nah
                    } else {
                        self.swipeVar.status = .none
                    }
                    
                 }
                 .onEnded { value in
                    if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                        self.swipeVar.status = .none
                        self.onRemove(self.restaurant)
                        self.socket.like(restaurantId: self.restaurant.id)
                    } else if self.getGesturePercentage(geometry, from: value) >= self.thresholdPercentage {
                        self.swipeVar.status = .none
                        self.onRemove(self.restaurant)
                        self.socket.like(restaurantId: self.restaurant.id)
                    } else {
                        self.translation = .zero
                    }
                }
            )
        }
    }
}
