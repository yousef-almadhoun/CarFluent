//
//  THomeCollection.swift
//  CarFluent
//
//  Created by mac on 12/8/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class THomeCollection : NSObject, NSCoding{
    
    var s_id_car : String!
    var s_Priority : String!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        s_id_car = dictionary["s_id_car"] as? String
        s_Priority = dictionary["s_Priority"] as? String
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
        if s_Priority != nil{
            dictionary["s_Priority"] = s_Priority
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
        s_Priority = aDecoder.decodeObject(forKey: "s_Priority") as? String
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if s_id_car != nil{
            aCoder.encode(s_id_car, forKey: "s_id_car")
        }
        if s_Priority != nil{
            aCoder.encode(s_Priority, forKey: "s_Priority")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
