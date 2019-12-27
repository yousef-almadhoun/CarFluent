//
//  FilterData.swift
//  CarFluent
//
//  Created by mac on 12/23/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class FilterData {
    
    var sort: String?
    
    var minPrice: String?
    
    var maxPrice: String?
    
    var officer: String?
    
    init (sort: String, minPrice: String, maxPrice: String, officer: String) {
        self.sort = sort
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.officer = officer
    }
    
}
