//
//  LoginView.swift
//  foodie
//
//  Created by Jae Hyun on 4/10/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginManager: LoginManager
    @ObservedObject private var keyboardSlider = KeyboardSlider()
    @State private var email = ""
    @State private var password = ""
      
    var body: some View {
        GeometryReader { g in
            VStack() {
                Text("foodie")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], g.size.height * 0.05)
                
                //foodie logo
                Image("chicken")
                    .resizable()
                    .frame(width: g.size.width * 0.75, height: g.size.height * 0.35)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding(.bottom, g.size.height * 0.05)
                
                // Errors
                if !self.loginManager.errors.isEmpty {
                    ForEach(self.loginManager.errors, id: \.self) { error in
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
                
                // Text Fields
                VStack(alignment: .leading, spacing: 15) {
                    LoginRegisterTextField(keyboardType: .default, returnVal: .next, tag: 0, autoComplete: .yes, text: self.$email, placeholder: "Username or Email", password: false)
                    LoginRegisterTextField(keyboardType: .default, returnVal: .done, tag: 1, autoComplete: .yes, text: self.$password, placeholder: "Password", password: true)
                }.padding([.leading, .trailing], 27.5)
                 .padding(.bottom, self.keyboardSlider.currentHeight)
                 .animation(.easeOut(duration: 0.16))

                
                // Sign in button
                Button(action: {
                    self.loginManager.login(email: self.email, password: self.password)
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: g.size.width * 0.8, height: g.size.height * 0.06)
                        .background(Color.green)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding(.top, 50)
                
                Spacer()
                
                // Register button
                HStack(spacing: 0) {
                    NavigationLink(destination: RegisterView())
                    {
                       Text("Don't have an account? Sign Up")
                    }
                }
                .padding(.bottom, 15)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
