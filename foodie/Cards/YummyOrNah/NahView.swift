//
//  NahView.swift
//  foodie
//
//  Created by Jae Hyun on 4/4/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct NahView: View {
    var body: some View {
        Text("NAH FAM")
        .bold()
            .font(.headline)
            .padding()
            .cornerRadius(10)
            .foregroundColor(Color.red)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 4.5)
            ).padding(.top, 45)
            .rotationEffect(Angle.degrees(45))
    }
}

struct NahView_Previews: PreviewProvider {
    static var previews: some View {
        NahView()
    }
}
