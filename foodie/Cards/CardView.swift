//
//  CardView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//
//
import SwiftUI

struct CardView: View {
    @State private var translation: CGSize = .zero
    
    private var restaurant: Restaurant
    private var onRemove: (_ restaurant: Restaurant) -> Void
    
    private var thresholdPercentage: CGFloat = 0.5
    
    init(restaurant: Restaurant, onRemove: @escaping (_ restaurant: Restaurant) -> Void) {
        self.restaurant = restaurant
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
           gesture.translation.width / geometry.size.width
       }

    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing:0) {
                Image(self.restaurant.imageName)
                .resizable()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.55)
                .scaledToFill()
                .clipped()
                
                ZStack {
                    Rectangle()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.1)
                        .foregroundColor(Color.white)

                    VStack{
                        Text(self.restaurant.name)
                        .foregroundColor(Color.black)
                        .font(.system(.largeTitle, design: .rounded))
                        .multilineTextAlignment(.leading)
                    }
                }
            }
            .cornerRadius(20)
            .padding(.horizontal, 20)
                .shadow(radius:7)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: self.translation.height)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                 DragGesture()
                 .onChanged { value in
                     self.translation = value.translation
                 }
                 .onEnded { value in
                    if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                        self.onRemove(self.restaurant)
                        }
                    else {
                        self.translation = .zero
                    }
                }
            )
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
