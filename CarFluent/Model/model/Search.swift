//
//  Search.swift
//  CarFluent
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class Search {
    
    var id: String?
    
    var image: String?
    
    var owner: String?
    
    var company: String?
    
    var type: String?
    
    var price: String?
    
    var watch: String?
    
    var rating: String?
    
    init (id: String, image: String, owner: String, company: String, type: String, price: String, watch: String, rating: String) {
        self.id = id
        self.image = image
        self.owner = owner
        self.company = company
        self.type = type
        self.price = price
        self.watch = watch
        self.rating = rating
    }
    
}
