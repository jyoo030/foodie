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
    @ObservedObject var userDefaultsManager: UserDefaultsManager
    @Published var restaurants:[Restaurant] = []
    @Published var restaurantDetails:RestaurantDetail = RestaurantDetail()
    @Published var reviews:[Review] = []
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
        getRestaurantsByRadius(radius: userDefaultsManager.settings.radius, location: userDefaultsManager.settings.location)
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
        guard let url = URL(string: "http://localhost:3000/restaurant/id/" + yelpID) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(RestaurantDetail.self, from: data)
                
                DispatchQueue.main.async {
                    self.restaurantDetails = json
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func getRestaurantReviews(yelpID: String) {
        guard let url = URL(string: "http://localhost:3000/restaurant/review/id/" + yelpID) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(Reviews.self, from: data)
                
                DispatchQueue.main.async {
                    self.reviews = json.reviews
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func onRemoveCard(restaurant: Restaurant) {
        self.restaurants.removeAll { $0.id == restaurant.id }
        self.restaurantDetails = RestaurantDetail()
        self.reviews = []
    }
    
    func isLastCard(index: Int) -> Bool {
        return index == self.restaurants.count - 1
    }
}
