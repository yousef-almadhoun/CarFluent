//
//  UITextFeildExtensions.swift
//  Test1
//
//  Created by Mahmoud Abo-Osama on 9/8/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor {
        set {
            self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: newValue])
        }
        get {
            return .white
        }
    }
    
    var isValidValue: Bool {
        return self.text?.count != 0 && self.text != nil && !(self.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false) != false
    }
}
