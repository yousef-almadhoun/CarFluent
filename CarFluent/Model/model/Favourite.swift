//
//  Favourite.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class Favourite {
    
    var idFavourite: String?
    
    var idCar: String?
    
    var priceCar: String?
    
    var imgCar: String?
    
    var title: String?
    
    var description: String?
    
    var rating: String?
    
    init(idFavourite: String, idCar: String, priceCar: String, imgCar: String, title: String, description: String, rating: String) {
        self.idFavourite = idFavourite
        self.idCar = idCar
        self.priceCar = priceCar
        self.imgCar = imgCar
        self.title = title
        self.description = description
        self.rating = rating
    }
    
}
