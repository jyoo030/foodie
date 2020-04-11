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
    @Published var error: String = ""
    @Published var success: Bool = false
    
    func login(email: String, password: String) {
        let apiUrl = ("http://localhost:3000/user/login")
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                                
                DispatchQueue.main.async {
                    if let httpResponse = resp as? HTTPURLResponse{
                        if httpResponse.statusCode == 400 {
                            self.success = false
                            self.error = (json as! [String:String])["msg"]!
                            return
                        }
                        
                        self.success = true
                        self.error = ""
                    }
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func register() {
        
    }
}
