//
//  UITextViewExtensions.swift
//  Test1
//
//  Created by Mahmoud Abo-Osama on 9/17/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    var isValidValue: Bool {
        return self.text?.count != 0 && self.text != nil && !(self.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false) != false
    }
}

