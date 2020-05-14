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
        onBackspace?()
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
        Coordinator(text: $text, isEnabled: $isEnabled)
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
        }
    }

    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isEnabled: Bool

        init(text: Binding<String>, isEnabled: Binding<Bool>) {
            self._text = text
            self._isEnabled = isEnabled
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if !isEnabled {
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
