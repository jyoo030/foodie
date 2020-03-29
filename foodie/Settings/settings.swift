//
//  settings.swift
//  foodie
//
//  Created by Jae Hyun on 3/26/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation

class Settings : ObservableObject {
    @Published var location:String
    @Published var radius:Int
    
    init()
    {
        location = "900 University Ave, Riverside, CA"
        radius = 2000
    }
}
