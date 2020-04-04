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
                // Image Slider
                VStack(alignment: .leading) {
                    if(self.networkingManager.restaurantDetails.photos.isEmpty) {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                         .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                    } else {
                        PagingView(index: self.$index.animation(), maxIndex: self.networkingManager.restaurantDetails.photos.count - 1) {
                            ForEach(self.networkingManager.restaurantDetails.photos, id: \.self) { imageUrl in
                                KFImage(URL(string: imageUrl)!)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                    }
                    
                    VStack(alignment: .leading, spacing: geometry.size.height * 0.03) {
                        //Card Title & Ratings
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
                        
                        //Restaurant Info
                        RestaurantInfoView()
                        
                    }.padding(.horizontal)
                    
                    // Reviews
                    if(self.networkingManager.reviews.isEmpty)
                    {
                        HStack {
                            Spacer()
                            
                            ActivityIndicator(isAnimating: .constant(true), style: .large)

                            Spacer()
                        }
                    } else {
                        ReviewView(reviews: self.networkingManager.reviews)
                    }
                    
                    // Map
                    MapView(centerCoordinate: CLLocationCoordinate2D(latitude: self.restaurant.coordinates["latitude"]!, longitude: self.restaurant.coordinates["longitude"]!), restaurantName: self.restaurant.name)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                    
                    // Yelp Logo
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            guard let url = URL(string: self.restaurant.url) else { return }
                            UIApplication.shared.open(url)
                        }) {
                            Image("yelpLogo").renderingMode(.original)
                            .resizable()
                                .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.10)
                            .scaledToFit()
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

