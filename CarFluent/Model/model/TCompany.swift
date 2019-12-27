//
//  TCompany.swift
//  CarFluent
//
//  Created by mac on 12/18/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class TCompany : NSObject, NSCoding{
    
    var s_Image : String!
    var s_Name : String!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        s_Image = dictionary["s_Image"] as? String
        s_Name = dictionary["s_name"] as? String
        udid = dictionary["udid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if s_Image != nil{
            dictionary["s_Image"] = s_Image
        }
        if s_Name != nil{
            dictionary["s_name"] = s_Name
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
        s_Image = aDecoder.decodeObject(forKey: "s_Image") as? String
        s_Name = aDecoder.decodeObject(forKey: "s_name") as? String
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if s_Image != nil{
            aCoder.encode(s_Image, forKey: "s_Image")
        }
        if s_Name != nil{
            aCoder.encode(s_Name, forKey: "s_name")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
