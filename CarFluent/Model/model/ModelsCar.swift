//
//  ModelsCar.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class ModelsCar {
    
    var idCar: String?
    
    var imgCar: String?
    
    var name: String?
    
    var price: String?
    
    init(idCar: String, imgCar: String, name: String, price: String) {
        self.idCar = idCar
        self.imgCar = imgCar
        self.name = name
        self.price = price
    }
    
}
