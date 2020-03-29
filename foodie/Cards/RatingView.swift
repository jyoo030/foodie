//
//  RatingView.swift
//  foodie
//
//  Created by Jae Hyun on 3/28/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    var rating: Float
    
    var wholeNumer: Int
    var remainder: Float

    var maximumRating = 5

    var onImage = Image(systemName: "star.fill")
    var halfImage = Image(systemName: "star.lefthalf.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    init(rating: Float){
        self.rating = rating
        wholeNumer = Int(floor(rating))
        remainder = rating.truncatingRemainder(dividingBy: 1)
    }
    
    var body: some View {
        HStack {

            ForEach(1..<wholeNumer + 1) { number in
                self.onImage
                    .foregroundColor(self.onColor)
            }
            
            if(remainder >= 0.5) {
                self.halfImage
                    .foregroundColor(self.onColor)
                
                ForEach(1..<5 - wholeNumer) { number in
                    self.onImage
                        .foregroundColor(self.offColor)
                }
            } else {
                ForEach(1..<5 - wholeNumer + 1) { number in
                    self.onImage
                        .foregroundColor(self.offColor)
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 2.4)
    }
}
