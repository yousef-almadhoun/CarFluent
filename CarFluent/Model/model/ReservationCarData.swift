//
//  ReservationCarData.swift
//  CarFluent
//
//  Created by mac on 12/9/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class ReservationCarData {
    
    var idPerson: String?
    
    var owner: String?
    
    var company: String?
    
    var type: String?
    
    var location: String?
    
    var timeTo: String?
    
    var timeFrom: String?
    
    var dateTo: String?
    
    var dateFrom: String?
    
    var idCar: String?
    
    var carPrice: String?
    
    var transmission: String?
    
    var fuel: String?
    
    var color: String?
    
    var fuelRatio: String?
    
    var paymentMethod: String?
    
    init(idPerson: String, owner: String, company: String, type: String, location: String, timeTo: String, timeFrom: String, dateTo: String, dateFrom: String, idCar: String, carPrice: String, transmission: String, fuel: String, color: String, fuelRatio: String, paymentMethod: String) {
        self.idPerson = idPerson
        self.owner = owner
        self.location = location
        self.company = company
        self.type = type
        self.timeTo = timeTo
        self.timeFrom = timeFrom
        self.dateTo = dateTo
        self.dateFrom = dateFrom
        self.idCar = idCar
        self.carPrice = carPrice
        self.transmission = transmission
        self.fuel = fuel
        self.color = color
        self.fuelRatio = fuelRatio
        self.paymentMethod = paymentMethod
    }
    
}
