//
//  CarSupply.swift
//  CarFluent
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class CarSupply {
    
    var id: String?
    
    var img: String?
    
    var name: String?
    
    var price: String?
    
    init(id: String, img: String, name: String, price: String) {
        self.id = id
        self.img = img
        self.name = name
        self.price = price
    }
    
}
