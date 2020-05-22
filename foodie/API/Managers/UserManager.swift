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
    @Published var searchResults: [User] = []
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getUser(id: String, onComplete: (() -> ())?) {
        let apiUrl = (UrlConstants.baseUrl + "/user/id/" + id)
        guard let url = URL(string: apiUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(User.self, from: data)
                                                 
                DispatchQueue.main.async {
                    self.userDefaultsManager.userId = json.id
                    self.userDefaultsManager.firstName = json.firstName
                    self.userDefaultsManager.lastName = json.lastName
                    self.userDefaultsManager.userName = json.userName
                    self.userDefaultsManager.email = json.email
                    self.userDefaultsManager.groups = json.groups!
                    self.userDefaultsManager.friends = json.friends!
                    if (json.currentGroup != nil) {
                        self.userDefaultsManager.currentGroup = json.currentGroup!
                    onComplete?()
                    }
                }
            } catch {
                print("caught in UserManager.getUser: \(error)")
            }
        }.resume()
    }
    
    func searchUsers(searchText: String) {
        if searchText.isEmpty {
            self.searchResults = []
            return
        }
        
        let apiUrl = (UrlConstants.baseUrl + "/user/search?searchText=" + searchText.replacingOccurrences(of: " ", with: "%20"))
        guard let url = URL(string: apiUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode([User].self, from: data)
                                                 
                DispatchQueue.main.async {
                    // Filter current account before setting
                    self.searchResults = json.filter({$0.id != self.userDefaultsManager.userId})
                }
            } catch {
                print("caught in UserManager.searchUsers: \(error)")
            }
        }.resume()
    }
}

