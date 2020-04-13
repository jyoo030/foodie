//
//  FooterView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack(spacing: 50) {
            Spacer()
            Button(
                action: {
                    // do something
                },
                label: { Image(systemName: "message").renderingMode(.original)
                    .resizable()
                    .frame(width: 35.0, height: 35.0)
                    .aspectRatio(contentMode: .fit)
                }
            )
            
            Button(
                action: {
                    // do somethingd
                },
                label: { Image(systemName: "person.crop.circle").renderingMode(.original)
                    .resizable()
                    .frame(width: 35.0, height: 35.0)
                    .aspectRatio(contentMode: .fit)
                }
            )
            
            Button(
                action: {
                    // do something
                },
                label: { Image(systemName: "gear").renderingMode(.original)
                    .resizable()
                    .frame(width: 35.0, height: 35.0)
                    .aspectRatio(contentMode: .fit)
                }
            )
            Spacer()
        }.shadow(radius: 7)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
