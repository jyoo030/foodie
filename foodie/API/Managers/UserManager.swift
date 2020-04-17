//
//  UserManager.swift
//  foodie
//
//  Created by Jae Hyun on 4/13/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserManager : ObservableObject {
    @ObservedObject var userDefaultsManager: UserDefaultsManager
    @ObservedObject var restaurantManager: RestaurantManager
    @Published var errors: [String] = []
    
    init(userDefaultsManager: UserDefaultsManager, restaurantManager: RestaurantManager) {
        self.userDefaultsManager = userDefaultsManager
        self.restaurantManager = restaurantManager
    }
    
    func getUser(id: String) {
        let apiUrl = (UrlConstants.baseUrl + "/user/id/" + id)
        guard let url = URL(string: apiUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(User.self, from: data)
                                                
                DispatchQueue.main.async {
                    self.userDefaultsManager.name = json.name
                    self.userDefaultsManager.email = json.email
                    self.userDefaultsManager.groups = json.groups!
                    self.userDefaultsManager.friends = json.friends!
                    if (json.currentGroup != nil) {
                        self.userDefaultsManager.currentGroup = json.currentGroup!
                        self.restaurantManager.getRestaurantsByRadius(radius: self.userDefaultsManager.currentGroup.radius, location: self.userDefaultsManager.currentGroup.location)
                    }
                }
            } catch {
                print("caught in UserManager: \(error)")
            }
        }.resume()
    }
}

