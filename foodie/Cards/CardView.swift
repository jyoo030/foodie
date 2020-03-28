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
    @Binding var restaurants:[Restaurant]
    @Binding var restaurant: Restaurant
    @State private var translation: CGSize = .zero
    
    var thresholdPercentage: CGFloat = 0.5
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
           gesture.translation.width / geometry.size.width
       }
    
    private func remove(restaurant: Restaurant) {
        restaurants.removeAll(where: { $0.id == restaurant.id })
    }

    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing:0) {
                Image("chicken")
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
                        self.remove(restaurant: self.restaurant)
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
