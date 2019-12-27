//
//  TReservationCar.swift
//  CarFluent
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class TReservationCar : NSObject, NSCoding{
    
    var color : String!
    var fuelRatio : String!
    var paymentMethod : String!
    var sCarPrice : String!
    var sDateFrom : String!
    var sDateTo : String!
    var sFuel : String!
    var sIdCar : String!
    var sIdPerson : String!
    var sLocation : String!
    var sOwner : String!
    var sTimeFrom : String!
    var sTimeTo : String!
    var sTransmission : String!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        color = dictionary["color"] as? String
        fuelRatio = dictionary["fuelRatio"] as? String
        paymentMethod = dictionary["paymentMethod"] as? String
        sCarPrice = dictionary["s_carPrice"] as? String
        sDateFrom = dictionary["s_dateFrom"] as? String
        sDateTo = dictionary["s_dateTo"] as? String
        sFuel = dictionary["s_fuel"] as? String
        sIdCar = dictionary["s_idCar"] as? String
        sIdPerson = dictionary["s_idPerson"] as? String
        sLocation = dictionary["s_location"] as? String
        sOwner = dictionary["s_owner"] as? String
        sTimeFrom = dictionary["s_timeFrom"] as? String
        sTimeTo = dictionary["s_timeTo"] as? String
        sTransmission = dictionary["s_transmission"] as? String
        udid = dictionary["udid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if color != nil{
            dictionary["color"] = color
        }
        if fuelRatio != nil{
            dictionary["fuelRatio"] = fuelRatio
        }
        if paymentMethod != nil{
            dictionary["paymentMethod"] = paymentMethod
        }
        if sCarPrice != nil{
            dictionary["s_carPrice"] = sCarPrice
        }
        if sDateFrom != nil{
            dictionary["s_dateFrom"] = sDateFrom
        }
        if sDateTo != nil{
            dictionary["s_dateTo"] = sDateTo
        }
        if sFuel != nil{
            dictionary["s_fuel"] = sFuel
        }
        if sIdCar != nil{
            dictionary["s_idCar"] = sIdCar
        }
        if sIdPerson != nil{
            dictionary["s_idPerson"] = sIdPerson
        }
        if sLocation != nil{
            dictionary["s_location"] = sLocation
        }
        if sOwner != nil{
            dictionary["s_owner"] = sOwner
        }
        if sTimeFrom != nil{
            dictionary["s_timeFrom"] = sTimeFrom
        }
        if sTimeTo != nil{
            dictionary["s_timeTo"] = sTimeTo
        }
        if sTransmission != nil{
            dictionary["s_transmission"] = sTransmission
        }
        if udid != nil{
            dictionary["udid"] = udid
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        color = aDecoder.decodeObject(forKey: "color") as? String
        fuelRatio = aDecoder.decodeObject(forKey: "fuelRatio") as? String
        paymentMethod = aDecoder.decodeObject(forKey: "paymentMethod") as? String
        sCarPrice = aDecoder.decodeObject(forKey: "s_carPrice") as? String
        sDateFrom = aDecoder.decodeObject(forKey: "s_dateFrom") as? String
        sDateTo = aDecoder.decodeObject(forKey: "s_dateTo") as? String
        sFuel = aDecoder.decodeObject(forKey: "s_fuel") as? String
        sIdCar = aDecoder.decodeObject(forKey: "s_idCar") as? String
        sIdPerson = aDecoder.decodeObject(forKey: "s_idPerson") as? String
        sLocation = aDecoder.decodeObject(forKey: "s_location") as? String
        sOwner = aDecoder.decodeObject(forKey: "s_owner") as? String
        sTimeFrom = aDecoder.decodeObject(forKey: "s_timeFrom") as? String
        sTimeTo = aDecoder.decodeObject(forKey: "s_timeTo") as? String
        sTransmission = aDecoder.decodeObject(forKey: "s_transmission") as? String
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if color != nil{
            aCoder.encode(color, forKey: "color")
        }
        if fuelRatio != nil{
            aCoder.encode(fuelRatio, forKey: "fuelRatio")
        }
        if paymentMethod != nil{
            aCoder.encode(paymentMethod, forKey: "paymentMethod")
        }
        if sCarPrice != nil{
            aCoder.encode(sCarPrice, forKey: "s_carPrice")
        }
        if sDateFrom != nil{
            aCoder.encode(sDateFrom, forKey: "s_dateFrom")
        }
        if sDateTo != nil{
            aCoder.encode(sDateTo, forKey: "s_dateTo")
        }
        if sFuel != nil{
            aCoder.encode(sFuel, forKey: "s_fuel")
        }
        if sIdCar != nil{
            aCoder.encode(sIdCar, forKey: "s_idCar")
        }
        if sIdPerson != nil{
            aCoder.encode(sIdPerson, forKey: "s_idPerson")
        }
        if sLocation != nil{
            aCoder.encode(sLocation, forKey: "s_location")
        }
        if sOwner != nil{
            aCoder.encode(sOwner, forKey: "s_owner")
        }
        if sTimeFrom != nil{
            aCoder.encode(sTimeFrom, forKey: "s_timeFrom")
        }
        if sTimeTo != nil{
            aCoder.encode(sTimeTo, forKey: "s_timeTo")
        }
        if sTransmission != nil{
            aCoder.encode(sTransmission, forKey: "s_transmission")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
