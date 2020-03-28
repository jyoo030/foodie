//
//  NetworkingManager.swift
//  foodie
//
//  Created by Jae Hyun on 3/25/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager : ObservableObject {
    @ObservedObject var settings:Settings = Settings()
    @Published var restaurants:[Restaurant] = []
    @Published var restaurantDetails = Restaurant()
    
    init() {
        getRestaurantsByRadius(radius: settings.radius, location: settings.location)
    }
    
    func getRestaurantsByRadius(radius: Int, location: String) {
        let apiUrl = ("http://localhost:3000/restaurant/radius/" + String(radius) + "?location=" + location).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: apiUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(RestaurantList.self, from: data)
                
                DispatchQueue.main.async {
                    self.restaurants = json.businesses
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func getRestaurantsDetails(yelpID:String) {
        guard let url = URL(string: "http://localhost:3000/id/" + yelpID) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            guard let data = data else {return}
            
            let response = try! JSONDecoder().decode(Restaurant.self, from: data)
            
            DispatchQueue.main.async {
                self.restaurantDetails = response
            }
        }.resume()
    }
}
