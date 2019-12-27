//
//  DateExtensions.swift
//  CarFluent
//
//  Created by mac on 12/2/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(customFormat: String, timeZone: String = "UTC") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.init(identifier: timeZone)
        dateFormatter.dateFormat = customFormat
        return dateFormatter.string(from: self)
    }
    
}
