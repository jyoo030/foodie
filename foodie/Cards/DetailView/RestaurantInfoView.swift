//
//  RestaurantInfoView.swift
//  foodie
//
//  Created by Jae Hyun on 4/2/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct RestaurantInfoView: View {
    @EnvironmentObject var networkingManager: NetworkingManager
    @State var formattedHours = []
    private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    func formatTime(time: String) -> String {
        var hours = Int(time.prefix(2))
        let minutes = Int(time.suffix(2))
        
        var nightDay = ""
        if hours! % 12 >= 0 {
            nightDay = "PM"
            if hours! > 12 {
                hours = hours! / 12
            }
        } else {
            nightDay = "AM"
        }
        
        return (String(hours!) + ":" + (minutes! == 0 ? "00" : String(minutes!)) + " " + nightDay)
    }

    var body: some View {
        Group {
            HStack {
                Spacer()
            ForEach(self.networkingManager.restaurantDetails.location.display_address, id: \.self) { address in
                    Text(address)
                        .font(.subheadline)
                    .bold()
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    let tel = "tel://"
                    let formattedString = tel + self.networkingManager.restaurantDetails.display_phone
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                   }) {
                    Text(self.networkingManager.restaurantDetails.display_phone)
                }
                
                Spacer()
            }
            
            VStack {
                if(!self.networkingManager.restaurantDetails.id.isEmpty && self.networkingManager.restaurantDetails.hours != nil) {
                    ForEach(self.networkingManager.restaurantDetails.hours![0].open, id: \.self) { hour in
                        HStack {
                            Text(self.days[hour.day])
                            Spacer()
                            Text(self.formatTime(time: hour.start) + " - " + self.formatTime(time: hour.end))
                        }.padding(.horizontal, 50)
                    }
                }
            }
        }
    }
}

struct RestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoView()
    }
}
