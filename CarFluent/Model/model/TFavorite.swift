//
//  TFavorite.swift
//  CarFluent
//
//  Created by mac on 12/20/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class TFavorite : NSObject, NSCoding{
    
    var s_IdCar : String!
    var s_IdUser : String!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        s_IdCar = dictionary["s_idCar"] as? String
        s_IdUser = dictionary["s_idUser"] as? String
        udid = dictionary["udid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if s_IdCar != nil{
            dictionary["s_idCar"] = s_IdCar
        }
        if s_IdUser != nil{
            dictionary["s_idUser"] = s_IdUser
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
        s_IdCar = aDecoder.decodeObject(forKey: "s_idCar") as? String
        s_IdUser = aDecoder.decodeObject(forKey: "s_idUser") as? String
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if s_IdCar != nil{
            aCoder.encode(s_IdCar, forKey: "s_idCar")
        }
        if s_IdUser != nil{
            aCoder.encode(s_IdUser, forKey: "s_idUser")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
