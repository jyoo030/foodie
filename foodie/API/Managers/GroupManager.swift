//
//  GroupManager.swift
//  foodie
//
//  Created by Jae Hyun on 4/15/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class GroupManager : ObservableObject {
    @ObservedObject var userManager: UserManager
    @Published var errors: [String] = []
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func createGroup(name: String,
                     users: [String],
                     admins: [String],
                     location: String,
                     radius: Int,
                     createdBy: String) {
        let apiUrl = (UrlConstants.baseUrl + "/group/create/")
        guard let url = URL(string: apiUrl) else {return}
        let body = ["name" : name,
                    "users" : users,
                    "admins" : admins,
                    "location" : location,
                    "radius": radius
            ] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode(Response.self, from: data)
                
                DispatchQueue.main.async {
                    if let httpResponse = resp as? HTTPURLResponse{
                        if httpResponse.statusCode == 400 {
                            self.errors = json.errors!
                            return
                        }
                        
                        self.errors = []
                        self.userManager.getUser(id: createdBy)
                    }
                }
            } catch {
                print("caught in GroupManager.createGroup: \(error)")
            }
        }.resume()
    }
}

