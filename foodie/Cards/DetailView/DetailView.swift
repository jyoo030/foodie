//
//  DetailView.swift
//  foodie
//
//  Created by Jae Hyun on 3/24/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI
import MapKit
import KingfisherSwiftUI

struct DetailView: View {
    @EnvironmentObject var networkingManager: NetworkingManager
    @State var index = 0
    
    var restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
        
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    PagingView(index: self.$index.animation(), maxIndex: self.networkingManager.restaurantDetails[0].photos!.count - 1) {
                        ForEach(self.networkingManager.restaurantDetails[0].photos!, id: \.self) { imageUrl in
                            KFImage(URL(string: imageUrl)!)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                        
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                    
                    VStack(alignment: .leading, spacing: geometry.size.height * 0.03) {
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
                        
                        HStack {
                            Spacer()
                        ForEach(self.networkingManager.restaurantDetails[0].location.display_address, id: \.self) { address in
                                Text(address)
                                    .font(.subheadline)
                                    .bold()
                            }
                            
                            Spacer()
                        }
                    }.padding(.horizontal)
                    
                    MapView(centerCoordinate: CLLocationCoordinate2D(latitude: self.restaurant.coordinates["latitude"]!, longitude: self.restaurant.coordinates["longitude"]!), restaurantName: self.restaurant.name)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                    
                }
            }
        }
    }
}

