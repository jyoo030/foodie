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
    var restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
        
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    KFImage(URL(string: self.restaurant.image_url)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                        .clipped()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(self.restaurant.name)
                                .font(.title)
                                .bold()
                            ForEach(self.networkingManager.restaurantDetails[0].location.display_address, id: \.self) { address in
                                Text(address)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Text(self.networkingManager.restaurantDetails[0].price ?? "N/A")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }.padding(.horizontal)

                    MapView(centerCoordinate: CLLocationCoordinate2D(latitude: self.restaurant.coordinates["latitude"]!, longitude: self.restaurant.coordinates["longitude"]!), restaurantName: self.restaurant.name)
                        .frame(height: geometry.size.height * 0.4)
                }
            }
        }
    }
}
