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
    var onEmptyBackspace: (()->Void)?
    
    convenience init(onEmptyBackspace: (()->Void)?) {
        self.init(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // some initialisation for init with no arguments
        self.onEmptyBackspace = onEmptyBackspace
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
            onEmptyBackspace?()
        }
    }
}

struct SearchBar: UIViewRepresentable {
    var placeholder:String?
    var keyboardType:UIKeyboardType?
    var textAlignment:NSTextAlignment?

    @Binding var text: String
    var onEmptyBackspace: (()->Void)?

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> EmptyDeleteTextField {
        let tmpView                 = EmptyDeleteTextField(onEmptyBackspace: onEmptyBackspace)
        tmpView.delegate            = context.coordinator as UITextFieldDelegate
        tmpView.placeholder         = placeholder
        tmpView.keyboardType        = keyboardType ?? .default
        tmpView.textAlignment       = textAlignment ?? .left
        tmpView.text                = text
        
        // Inner Text Padding
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        tmpView.leftView = leftView
        tmpView.leftViewMode = .always
        
        return tmpView
    }

    func updateUIView(_ uiView: EmptyDeleteTextField, context: UIViewRepresentableContext<SearchBar>) {
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
    }
}
