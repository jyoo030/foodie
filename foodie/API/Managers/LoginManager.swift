//
//  LoginManager.swift
//  foodie
//
//  Created by Jae Hyun on 4/10/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class LoginManager : ObservableObject {
    @ObservedObject var userDefaultsManager: UserDefaultsManager
    @Published var errors: [String] = []
    @Published var success: Bool = false
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func login(email: String, password: String) {
        let apiUrl = (UrlConstants.baseUrl + "/user/login")
        guard let url = URL(string: apiUrl) else {return}
        let body = ["email" : email, "password" : password]
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
                            self.success = false
                            self.errors = json.errors!
                            self.userDefaultsManager.userId = ""
                            return
                        }
                        
                        self.success = true
                        self.errors = []
                        self.userDefaultsManager.userId = json.userId!
                    }
                }
            } catch {
                print("caught in LoginManager.Login: \(error)")
            }
        }.resume()
    }
    
    func register(firstName: String, lastName: String, userName: String, email: String, password: String, password2: String) {
        let apiUrl = (UrlConstants.baseUrl + "/user/register")
        guard let url = URL(string: apiUrl) else {return}
        let body = ["firstName": firstName, "lastName": lastName, "userName": userName, "email" : email, "password" : password, "password2": password2]
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
                            self.success = false
                            self.errors = json.errors!
                            self.userDefaultsManager.userId = ""
                            return
                        }
                        
                        self.success = true
                        self.errors = []
                        self.userDefaultsManager.userId = json.userId!
                    }
                }
            } catch {
                print("caught in LoginManager.register: \(error)")
            }
        }.resume()
    }
}
