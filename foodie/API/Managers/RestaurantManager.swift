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

class RestaurantManager : ObservableObject {
    @Published var restaurants:[Restaurant] = []
    @Published var restaurantDetails:RestaurantDetail = RestaurantDetail()
    @Published var reviews:[Review] = []
    
    func getRestaurantsByRadius(radius: Int, location: String, offset: Int?) {
        var apiUrl = UrlConstants.baseUrl
        apiUrl += "/restaurant/radius/\(String(radius))"
        apiUrl += "?location=\(location)"
        if offset != nil {
            apiUrl += "&offset=\(String(offset!))"
        }
        apiUrl = apiUrl.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: apiUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(RestaurantList.self, from: data)
                
                DispatchQueue.main.async {
                    self.restaurants = json.businesses
                }
            } catch {
                print("caught in RestaurantManager.getRestaurantsByRadius: \(error)")
            }
        }.resume()
    }
    
    func getRestaurantsDetails(yelpID:String) {
        guard let url = URL(string: UrlConstants.baseUrl + "/restaurant/id/" + yelpID) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(RestaurantDetail.self, from: data)
                
                DispatchQueue.main.async {
                    self.restaurantDetails = json
                }
            } catch {
                print("caught in RestaurantManager.getRestaurantsDetails: \(error)")
            }
        }.resume()
    }
    
    func getRestaurantReviews(yelpID: String) {
        guard let url = URL(string: UrlConstants.baseUrl + "/restaurant/review/id/" + yelpID) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(Reviews.self, from: data)
                
                DispatchQueue.main.async {
                    self.reviews = json.reviews
                }
            } catch {
                print("caught in RestaurantManager.getRestaurantReviews: \(error)")
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
