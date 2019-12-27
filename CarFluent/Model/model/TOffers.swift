//
//  TOffers.swift
//  CarFluent
//
//  Created by mac on 12/7/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class TOffers : NSObject, NSCoding{
    
    var s_id_car : String!
    var i_offer_price : Int!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        s_id_car = dictionary["s_id_car"] as? String
        i_offer_price = dictionary["i_offer_price"] as? Int
        udid = dictionary["udid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if s_id_car != nil{
            dictionary["s_id_car"] = s_id_car
        }
        if i_offer_price != nil{
            dictionary["i_offer_price"] = i_offer_price
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
        s_id_car = aDecoder.decodeObject(forKey: "s_id_car") as? String
        i_offer_price = aDecoder.decodeObject(forKey: "i_offer_price") as? Int
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if s_id_car != nil{
            aCoder.encode(s_id_car, forKey: "i_id_car")
        }
        if i_offer_price != nil{
            aCoder.encode(i_offer_price, forKey: "s_offer_price")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
