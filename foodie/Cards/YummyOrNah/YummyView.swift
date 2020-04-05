//
//  YummyView.swift
//  foodie
//
//  Created by Jae Hyun on 4/4/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct YummyView: View {
    var body: some View {
        Text("YUMMY")
            .font(.headline)
        .padding()
        .cornerRadius(10)
            .foregroundColor(Color.orange)
        .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.orange, lineWidth: 3.0))
            .padding(24)
            .rotationEffect(Angle.degrees(-45))
    }
}

struct YummyView_Previews: PreviewProvider {
    static var previews: some View {
        YummyView()
    }
}
