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
    @Published var errors: [String] = []
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getUser(id: String) {
        let apiUrl = (UrlConstants.baseUrl + "/user/id/" + id)
        guard let url = URL(string: apiUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(User.self, from: data)
                
                print("User: \(json)")
                                
                DispatchQueue.main.async {
                    self.userDefaultsManager.name = json.name
                    self.userDefaultsManager.email = json.email
                    self.userDefaultsManager.groups = json.groups!
                    self.userDefaultsManager.friends = json.friends!
                }
            } catch {
                print("caught in UserManager: \(error)")
            }
        }.resume()
    }
}

