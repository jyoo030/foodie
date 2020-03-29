//
//  DetailView.swift
//  foodie
//
//  Created by Jae Hyun on 3/24/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var networkingManager: NetworkingManager
    var yelpBusinessID: String
    
    init(yelpBusinessID: String) {
        self.yelpBusinessID = yelpBusinessID
    }
        
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Image("pizza")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                        .clipped()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(self.networkingManager.restaurantDetails.name)
                                .font(.title)
                                .bold()
                            ForEach(self.networkingManager.restaurantDetails.location.display_address, id: \.self) { address in
                                Text(address)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Text(self.networkingManager.restaurantDetails.price ?? "N/A")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }.padding(.horizontal)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(yelpBusinessID: "WavvLdfdP6g8aZTtbBQHTw")
    }
}
