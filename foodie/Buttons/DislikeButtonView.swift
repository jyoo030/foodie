//
//  DislikeButtonView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct DislikeButtonView: View {
    var body: some View {
        Button(
            action: {
                // do something
            },
            label: { Image("dislike_button").renderingMode(.original)
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .aspectRatio(contentMode: .fit)
                .padding(10)
            }
        )
        .background(Color.white)
            .clipShape(Circle())
        .frame(width: 60.0, height: 60.0)
        .shadow(radius: 7)
    }
}

struct DislikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DislikeButtonView()
    }
}
