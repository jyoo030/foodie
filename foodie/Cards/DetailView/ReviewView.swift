//
//  ReviewView.swift
//  foodie
//
//  Created by Jae Hyun on 4/2/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ReviewView: View {
    var reviews: [Review]
    
    init(reviews: [Review]) {
        self.reviews = reviews
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(reviews, id: \.id) {review in
                HStack {
                    if(review.user.image_url == nil) {
                        Image("chicken")
                        .resizable()
                            .frame(width: 70, height: 70)
                        .scaledToFill()

                    } else {
                        KFImage(URL(string: review.user.image_url!))
                        .resizable()
                            .frame(width: 70, height: 70)
                        .scaledToFill()

                    }
                    
                    Text(review.text).font(.subheadline)
                }.padding(.horizontal)
            }
        }
    }
}

