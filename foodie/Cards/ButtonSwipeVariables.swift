//
//  ButtonSwipeVariables.swift
//  foodie
//
//  Created by Jae Hyun on 4/5/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class SwipeVar : ObservableObject {
    @Published var toggle: CGFloat = 0
    @Published var degree: Double = 0
    @Published var status: yumOrNah = .none
}
