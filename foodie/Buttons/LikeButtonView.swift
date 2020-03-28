//
//  LikeButtonView.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct LikeButtonView: View {

    var body: some View {
        GeometryReader { geometry in
            Button(
              action: {
                    
              },
              label: { Image("like_button").renderingMode(.original)
                  .resizable()
                  .frame(width: geometry.size.width*0.2, height: geometry.size.width*0.2)
                  .aspectRatio(contentMode: .fit)
                  .padding(10)
              }
            )
            .background(Color.white)
            .clipShape(Circle())
            .frame(width: geometry.size.width*0.2, height: geometry.size.width*0.2)
            .shadow(radius: 7)
        }

    }
}

struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView()
    }
}
