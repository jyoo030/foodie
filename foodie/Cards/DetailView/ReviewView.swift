//
//  ReviewView.swift
//  foodie
//
//  Created by Jae Hyun on 4/2/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import Foundation

struct ReviewView: View {
    var reviews: [Review]
    
    init(reviews: [Review]) {
        self.reviews = reviews
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(reviews, id: \.id) {review in
                HStack(spacing: 10) {
                    VStack {
                        Spacer()
                        if(review.user.image_url == nil) {
                            Button(action: {
                                guard let url = URL(string: review.user.profile_url) else { return }
                                UIApplication.shared.open(url)
                            }) {
                                Image("chicken")
                                    .renderingMode(.original)
                                .resizable()
                                    .frame(width: 70, height: 70)
                                .scaledToFill()
                            }
                        } else {
                            Button(action: {
                                guard let url = URL(string: review.user.profile_url) else { return }
                                UIApplication.shared.open(url)
                            }) {
                                KFImage(URL(string: review.user.image_url!))
                                    .renderingMode(.original)
                                .resizable()
                                    .frame(width: 70, height: 70)
                                .scaledToFill()
                            }
                        }
                        
                        Text(review.user.name).font(.caption)
                        Spacer()
                    }
                    
                    VStack(spacing: 0) {
                        HStack{
                            Spacer()
                            RatingView(rating: review.rating).padding(.bottom, 10)
                        }

                        Text(review.text).font(.subheadline)
                        
                        HStack {
                            Text(review.time_created.components(separatedBy: " ")[0])
                                .font(.caption)
                            .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Button(action: {
                                  guard let url = URL(string: review.url) else { return }
                                  UIApplication.shared.open(url)
                              }) {
                                Text("Read More...").font(.caption)
                            }
                        }.padding(.top, 3)
                    }
                    
                    
                    
                }.padding(.horizontal)
            }
        }
    }
}

