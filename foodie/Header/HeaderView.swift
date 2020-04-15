//
//  HeaderView.swift
//  foodie
//
//  Created by Jae Hyun on 3/19/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color(red: 247/255, green: 114/255, blue: 203/255, opacity: 0.7))
                    .frame(width: geometry.size.width * 1.3)
                
                GroupView()
                .offset(y:geometry.size.height*0.06)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
