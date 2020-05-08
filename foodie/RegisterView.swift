//
//  RegisterView.swift
//  foodie
//
//  Created by Jae Hyun on 4/10/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var loginManager: LoginManager
    @ObservedObject private var keyboardSlider = KeyboardSlider()

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var password2 = ""
    
    var body: some View {
        GeometryReader { g in
            VStack() {
                Text("Sign Up")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], g.size.height * 0.05)
                
                // Errors
                if !self.loginManager.errors.isEmpty {
                    ForEach(self.loginManager.errors, id: \.self) { error in
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
                
                // Text Fields
                VStack(alignment: .leading, spacing: 25) {
                    LoginRegisterTextField(keyboardType: .default, returnVal: .next, tag: 0, autoComplete: .yes, text: self.$firstName, placeholder: "First Name", password: false)
                    LoginRegisterTextField(keyboardType: .default, returnVal: .next, tag: 1, autoComplete: .yes, text: self.$lastName, placeholder: "Last Name", password: false)
                    LoginRegisterTextField(keyboardType: .default, returnVal: .next, tag: 2, autoComplete: .no, text: self.$userName, placeholder: "User Name", password: false)
                    LoginRegisterTextField(keyboardType: .default, returnVal: .next, tag: 3, autoComplete: .no, text: self.$email, placeholder: "Email", password: false)
                    LoginRegisterTextField(keyboardType: .default, returnVal: .next, tag: 4, autoComplete: .no, text: self.$password, placeholder: "Password", password: true)
                    LoginRegisterTextField(keyboardType: .default, returnVal: .done, tag: 5, autoComplete: .no, text: self.$password2, placeholder: "Confirm Password", password: true)
                }.padding(EdgeInsets(top: 8, leading: 27.5, bottom: self.keyboardSlider.currentHeight, trailing: 27.5))
                 .animation(.easeOut(duration: 0.16))
                
                // Sign in button
                Button(action: {
                    self.loginManager.register(
                        firstName: self.firstName,
                        lastName: self.lastName,
                        userName: self.userName,
                        email: self.email,
                        password: self.password,
                        password2: self.password2)
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: g.size.width * 0.8, height: g.size.height * 0.06)
                        .background(Color.green)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding(.top, 50)
                
                Spacer()
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
