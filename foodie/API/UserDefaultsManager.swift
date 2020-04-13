//
//  UserDefaultsManager.swift
//  foodie
//
//  Created by Jae Hyun on 4/11/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserDefaultsManager : ObservableObject {
    @Published var userId: String = UserDefaults.standard.string(forKey: "userId") ?? "" {
        didSet { UserDefaults.standard.set(self.userId, forKey: "userId") }
    }
    
    @Published var settings: Settings = (UserDefaults.standard.object(forKey: "settings") ?? Settings()) as! Settings {
        didSet { UserDefaults.standard.set(self.settings, forKey: "settings") }
    }
}
