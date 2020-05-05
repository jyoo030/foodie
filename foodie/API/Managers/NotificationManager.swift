//
//  NotificationManager.swift
//  foodie
//
//  Created by Jae Hyun on 5/3/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NotificationManager : ObservableObject {
    @ObservedObject var userManager: UserManager
    @ObservedObject var userDefaultsManager: UserDefaultsManager
    @Published var recieved: [NotificationModel] = []
    @Published var sent: [NotificationModel] = []
    @Published var errors = []
    
    init(userManager: UserManager, userDefaultsManager: UserDefaultsManager) {
        self.userManager = userManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getNotifications(userId: String) {
        let apiUrl = ( UrlConstants.baseUrl + "/notification/id/" + userId)
        guard let url = URL(string: apiUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            do {
                guard let data = data else {return}
                let json = try JSONDecoder().decode([NotificationModel].self, from: data)
                
                print(json)
                
                DispatchQueue.main.async {
                    self.recieved = json.filter{$0.reciever == userId}
                    self.sent = json.filter{$0.sender.id == userId}
                }
            } catch {
                print("caught in NotificationsManager.getNotifications: \(error)")
            }
        }.resume()
    }
    
    func respond(notificationId: String, response: Bool) {
       let apiUrl = (UrlConstants.baseUrl + "/notification/id/" + notificationId + "?response=" + String(response))
             guard let url = URL(string: apiUrl) else {return}
             let body = [:] as [String : Any]
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
                            
                            self.userManager.getUser(id: self.userDefaultsManager.userId)
                            
                            self.errors = []
                         }
                     }
                 } catch {
                     print("caught in NotificationsManager.respond: \(error)")
                 }
             }.resume()
    }
}
