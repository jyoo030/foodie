//
//  DetailView.swift
//  foodie
//
//  Created by Jae Hyun on 3/24/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @State var yelpBusinessID: String

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
                            Text("Debra Weber, 28")
                                .font(.title)
                                .bold()
                            Text("Judge")
                                .font(.subheadline)
                                .bold()
                            Text("13 Mutual Friends")
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
