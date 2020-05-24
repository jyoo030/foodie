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
    private var restaurant: Restaurant
    var thresholdPercentage: CGFloat = 0.3
    var index: Int
    @State private var translation: CGSize = .zero
    @Binding var isDisabled: Bool
    @ObservedObject var swipeVar: SwipeVar
    @EnvironmentObject var socket: Socket

    @EnvironmentObject var restaurantManager: RestaurantManager
    
    init(restaurant: Restaurant, index: Int, swipeVar: SwipeVar, isDisabled: Binding<Bool>) {
        self.restaurant = restaurant
        self.swipeVar = swipeVar
        self.index = index
        self._isDisabled = isDisabled
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
           gesture.translation.width / geometry.size.width
       }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    // Restaurant Image
                    KFImage(URL(string: self.restaurant.image_url)!)
                    .resizable()
                        .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.98, height: geometry.size.height * 0.98)


                    // Yum or Nah
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
                    
                    // Restaurant Name, Price, Rating
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
                    }.padding()
                }
                .frame(width: geometry.size.width * 0.98, height: geometry.size.height * 0.98)
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
                        if !self.isDisabled {
                             self.translation = value.translation
                            if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                                self.swipeVar.status = .yum
                            } else if (self.getGesturePercentage(geometry, from: value)) <= -self.thresholdPercentage {
                                self.swipeVar.status = .nah
                            } else {
                                self.swipeVar.status = .none
                            }
                        }
                     }
                     .onEnded { value in
                        if self.getGesturePercentage(geometry, from: value) >= self.thresholdPercentage {
                            if !self.isDisabled {
                                self.isDisabled = true
                                                   
                                // Moves card right off screen
                                self.swipeVar.toggle = 500
                                
                                // Delay for card to leave screen before deleting
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    self.restaurantManager.onRemoveCard(restaurant: self.restaurant)
                                    self.swipeVar.toggle = 0
                                    self.swipeVar.status = .none
                                }
                                
                                // Delay between swipes
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    self.isDisabled = false
                                }
                                
                                self.socket.like(restaurantId: self.restaurant.id)
                            }
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            if !self.isDisabled {
                                self.isDisabled = true
                                // Moves card left off screen
                                self.swipeVar.toggle = -500
                                
                                // Delay for card to leave screen before deleting
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    self.restaurantManager.onRemoveCard(restaurant: self.restaurant)
                                    self.swipeVar.toggle = 0
                                    self.swipeVar.status = .none
                                }
                                
                                // Delay between swipes
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    self.isDisabled = false
                                }
                                
                                self.socket.like(restaurantId: self.restaurant.id)
                            }
                        } else {
                            self.isDisabled = false
                            self.translation = .zero
                        }
                    }
                )
                Spacer()
            }
        }
    }
}
