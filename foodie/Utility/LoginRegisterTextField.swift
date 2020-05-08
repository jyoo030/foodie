//
//  LoginRegisterTextField.swift
//  foodie
//
//  Created by Justin Yoo on 5/7/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI
import UIKit

struct LoginRegisterTextField: UIViewRepresentable {
    let keyboardType: UIKeyboardType
    let returnVal: UIReturnKeyType
    let tag: Int
    let autoComplete: UITextAutocorrectionType
    @Binding var text: String
    let placeholder: String
    let password: Bool
    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = self.keyboardType
        textField.returnKeyType = self.returnVal
        textField.tag = self.tag
        textField.delegate = context.coordinator
        textField.autocorrectionType = self.autoComplete
        textField.placeholder = self.placeholder
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20.0
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowRadius = 20.0
        textField.layer.shadowOffset = CGSize(width: 20, height: 10)
        textField.isSecureTextEntry = password
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: LoginRegisterTextField

        init(_ textField: LoginRegisterTextField) {
            self.parent = textField
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print("here")
            let nextTag = textField.tag + 1

            if let nextResponder = textField.superview?.superview?.viewWithTag(nextTag) {
                nextResponder.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }

            return true
        }
    }
}


