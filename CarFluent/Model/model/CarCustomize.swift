//
//  CarCustomize.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class CarCustomize {
    
    var idCar: String?
    
    var imgCar: String?
    
    var name: String?
    
    var oldPrice: String?
    
    var newPrice: String?
    
    init(idCar: String, imgCar: String, name: String, oldPrice: String, newPrice: String) {
        self.idCar = idCar
        self.imgCar = imgCar
        self.name = name
        self.oldPrice = oldPrice
        self.newPrice = newPrice
    }
    
}
