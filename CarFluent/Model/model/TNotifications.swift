//
//  TNotifications.swift
//  CarFluent
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class TNotifications: NSObject, NSCoding {
    
    var b_isRead : Bool!
    var s_date : String!
    var s_from : String!
    var s_IdReservation : String!
    var s_message : String!
    var s_to : String!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        b_isRead = dictionary["b_isRead"] as? Bool
        s_date = dictionary["s_date"] as? String
        s_from = dictionary["s_from"] as? String
        s_IdReservation = dictionary["s_idReservation"] as? String
        s_message = dictionary["s_message"] as? String
        s_to = dictionary["s_to"] as? String
        udid = dictionary["udid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if b_isRead != nil{
            dictionary["b_isRead"] = b_isRead
        }
        if s_date != nil{
            dictionary["s_date"] = s_date
        }
        if s_from != nil{
            dictionary["s_from"] = s_from
        }
        if s_IdReservation != nil{
            dictionary["s_idReservation"] = s_IdReservation
        }
        if s_message != nil{
            dictionary["s_message"] = s_message
        }
        if s_to != nil{
            dictionary["s_to"] = s_to
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
        b_isRead = aDecoder.decodeObject(forKey: "b_isRead") as? Bool
        s_date = aDecoder.decodeObject(forKey: "s_date") as? String
        s_from = aDecoder.decodeObject(forKey: "s_from") as? String
        s_IdReservation = aDecoder.decodeObject(forKey: "s_idReservation") as? String
        s_message = aDecoder.decodeObject(forKey: "s_message") as? String
        s_to = aDecoder.decodeObject(forKey: "s_to") as? String
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if b_isRead != nil{
            aCoder.encode(b_isRead, forKey: "b_isRead")
        }
        if s_date != nil{
            aCoder.encode(s_date, forKey: "s_date")
        }
        if s_from != nil{
            aCoder.encode(s_from, forKey: "s_from")
        }
        if s_IdReservation != nil{
            aCoder.encode(s_IdReservation, forKey: "s_idReservation")
        }
        if s_message != nil{
            aCoder.encode(s_message, forKey: "s_message")
        }
        if s_to != nil{
            aCoder.encode(s_to, forKey: "s_to")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
