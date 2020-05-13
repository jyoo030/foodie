//
//  LoginRegisterTextField.swift
//  foodie
//
//  Created by Justin Yoo on 5/7/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    var placeholder:String?
    var keyboardType:UIKeyboardType?
    var textAlignment:NSTextAlignment?
    let tag: Int
    let returnVal: UIReturnKeyType
    let password: Bool

    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let tmpView                 = UITextField()
        tmpView.delegate            = context.coordinator as UITextFieldDelegate
        tmpView.placeholder         = placeholder
        tmpView.keyboardType        = keyboardType ?? .default
        tmpView.textAlignment       = textAlignment ?? .left
        tmpView.tag                 = tag
        tmpView.backgroundColor     = .white
        tmpView.layer.cornerRadius  = 10.0
        tmpView.layer.shadowOpacity = 0.5
        tmpView.layer.shadowColor   = UIColor.black.cgColor
        tmpView.layer.shadowRadius  = 20.0
        tmpView.layer.shadowOffset  = CGSize(width: 20, height: 10)
        tmpView.isSecureTextEntry   = password
        tmpView.returnKeyType       = returnVal 
        tmpView.font = UIFont.systemFont(ofSize: 25)

        // Inner Text Padding
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        tmpView.leftView = leftView
        tmpView.leftViewMode = .always
        
        
        return tmpView
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiView.text = text
    }

    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            self._text = text
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentValue            = textField.text as NSString? {
                let proposedValue          = currentValue.replacingCharacters(in: range, with: string)
                text                       = proposedValue
            }
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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

