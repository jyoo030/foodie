//
//  SearchBar.swift
//  foodie
//
//  Created by Jae Hyun on 5/9/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI
import UIKit

class EmptyDeleteTextField: UITextField {
    var onBackspace: (()->Void)?
    
    convenience init(onBackspace: (()->Void)?) {
        self.init(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // some initialisation for init with no arguments
        self.onBackspace = onBackspace
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        //  some initialisation for init with frame
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        if self.text?.count == 0 {
            onBackspace?()
        }
    }
}

struct SearchBar: UIViewRepresentable {
    var placeholder: String?
    var keyboardType: UIKeyboardType?
    var textAlignment: NSTextAlignment?
    
    @Binding var isEnabled: Bool
    @Binding var text: String
    
    var onBackspace: (()->Void)?

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, isEnabled: $isEnabled, onBackspace: onBackspace)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> EmptyDeleteTextField {
        let tmpView                 = EmptyDeleteTextField(onBackspace: onBackspace)
        tmpView.delegate            = context.coordinator as UITextFieldDelegate
        tmpView.placeholder         = placeholder
        tmpView.keyboardType        = keyboardType ?? .default
        tmpView.textAlignment       = textAlignment ?? .left
        tmpView.text                = text
        
        return tmpView
    }

    func updateUIView(_ uiView: EmptyDeleteTextField, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        if !isEnabled {
            uiView.tintColor = UIColor.clear
        } else {
            uiView.tintColor = UIColor.black
        }
    }

    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isEnabled: Bool
        var onBackspace: (()->Void)?

        init(text: Binding<String>, isEnabled: Binding<Bool>, onBackspace: (()->Void)?) {
            self._text = text
            self._isEnabled = isEnabled
            self.onBackspace = onBackspace
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            var isEnabledAfterCall: Bool
            
            isEnabledAfterCall = isEnabled
            
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    onBackspace?()
                }
            }
            
            if !isEnabledAfterCall {
                return false
            }

            if let currentValue            = textField.text as NSString? {
                let proposedValue          = currentValue.replacingCharacters(in: range, with: string)
                DispatchQueue.main.async {
                    self.text                       = proposedValue
                }
            }
            return true
        }
    }
}
