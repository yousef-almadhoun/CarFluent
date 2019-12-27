//
//  StringExtensions.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 9/24/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let regularExpressionForPhone = "^\\d{3}\\d{3}\\d{4}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        if self.count < 8 || self.count > 15 {
            return false
        }
        return true
    }
    
    var image_: UIImage? {
        return UIImage.init(named: self)
    }
    
    var color_: UIColor {
        return UIColor.init(named: self) ?? UIColor.white
    }
    
    var localize_: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toDate(customFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
        dateFormatter.dateFormat = customFormat
        return dateFormatter.date(from: self) ?? Date()
    }
    
}
