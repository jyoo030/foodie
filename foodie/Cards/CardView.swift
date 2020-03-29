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

struct CardView: View {
    private var onRemove: (_ Restaurant: Restaurant) -> Void
    private var restaurant: Restaurant
    var thresholdPercentage: CGFloat = 0.5
    @State private var translation: CGSize = .zero
    
    init(restaurant: Restaurant, onRemove: @escaping (_ Restaurant: Restaurant) -> Void) {
        self.restaurant = restaurant
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
           gesture.translation.width / geometry.size.width
       }

    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing:0) {
                KFImage(URL(string: self.restaurant.image_url)!)
                .resizable()
                    .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.55)

                VStack(alignment: .leading) {
                    HStack {
                        Text(self.restaurant.name)
                            .font(.system(size: geometry.size.width * 0.06))
                            .bold()
                        
                        Spacer()

                        Text(self.restaurant.price ?? "")
                        .font(.headline)
                        .foregroundColor(.gray)
                    }
                    
                    HStack {
                        RatingView(rating: Float(self.restaurant.rating))
                        
                        Spacer()

                        Text(String(self.restaurant.review_count) + " Reviews")
                        .font(.headline)
                        .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, geometry.size.height * 0.02)
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                .background(Color.white)
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
