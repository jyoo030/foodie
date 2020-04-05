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
        .bold()
            .font(.headline)
        .padding()
        .cornerRadius(10)
            .foregroundColor(Color.green)
        .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.green, lineWidth: 4.5))
            .padding(24)
            .rotationEffect(Angle.degrees(-45))
    }
}

struct YummyView_Previews: PreviewProvider {
    static var previews: some View {
        YummyView()
    }
}
