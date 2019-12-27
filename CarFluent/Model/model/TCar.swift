//
//  TCar.swift
//  CarFluent
//
//  Created by mac on 12/3/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class TCar : NSObject, NSCoding{
    
    var dt_CreateAt : String!
    var enable : Bool!
    var i_Price : Int!
    var i_Watch : Int!
    var s_CarOwner : String!
    var ar_Color : [String]!
    var s_Company : String!
    var s_Description : String!
    var ar_Image : [String]!
    var s_Rating : String!
    var s_Title : String!
    var s_Type : String!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        ar_Image = dictionary["ar_Image"] as? [String]
        ar_Color = dictionary["ar_Color"] as? [String]
        dt_CreateAt = dictionary["dt_create_at"] as? String
        enable = dictionary["enable"] as? Bool
        i_Price = dictionary["i_price"] as? Int
        i_Watch = dictionary["i_watch"] as? Int
        s_CarOwner = dictionary["s_carOwner"] as? String
        s_Company = dictionary["s_company"] as? String
        s_Description = dictionary["s_description"] as? String
        s_Rating = dictionary["s_rating"] as? String
        s_Title = dictionary["s_title"] as? String
        s_Type = dictionary["s_type"] as? String
        udid = dictionary["udid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dt_CreateAt != nil{
            dictionary["dt_create_at"] = dt_CreateAt
        }
        if enable != nil{
            dictionary["enable"] = enable
        }
        if i_Price != nil{
            dictionary["i_price"] = i_Price
        }
        if i_Watch != nil{
            dictionary["i_watch"] = i_Watch
        }
        if s_CarOwner != nil{
            dictionary["s_carOwner"] = s_CarOwner
        }
        if s_Company != nil{
            dictionary["s_company"] = s_Company
        }
        if s_Description != nil{
            dictionary["s_description"] = s_Description
        }
        if s_Rating != nil{
            dictionary["s_rating"] = s_Rating
        }
        if s_Title != nil{
            dictionary["s_title"] = s_Title
        }
        if s_Type != nil{
            dictionary["s_type"] = s_Type
        }
        if udid != nil{
            dictionary["udid"] = udid
        }
        if ar_Image != nil{
            dictionary["ar_Image"] = ar_Image
        }
        if ar_Color != nil{
            dictionary["ar_Color"] = ar_Color
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        dt_CreateAt = aDecoder.decodeObject(forKey: "dt_create_at") as? String
        enable = aDecoder.decodeObject(forKey: "enable") as? Bool
        i_Price = aDecoder.decodeObject(forKey: "i_price") as? Int
        i_Watch = aDecoder.decodeObject(forKey: "i_watch") as? Int
        s_CarOwner = aDecoder.decodeObject(forKey: "s_carOwner") as? String
        ar_Color = aDecoder.decodeObject(forKey: "ar_Color") as? [String]
        s_Company = aDecoder.decodeObject(forKey: "s_company") as? String
        s_Description = aDecoder.decodeObject(forKey: "s_description") as? String
        ar_Image = aDecoder.decodeObject(forKey: "ar_Image") as? [String]
        s_Rating = aDecoder.decodeObject(forKey: "s_rating") as? String
        s_Title = aDecoder.decodeObject(forKey: "s_title") as? String
        s_Type = aDecoder.decodeObject(forKey: "s_type") as? String
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if dt_CreateAt != nil{
            aCoder.encode(dt_CreateAt, forKey: "dt_create_at")
        }
        if enable != nil{
            aCoder.encode(enable, forKey: "enable")
        }
        if i_Price != nil{
            aCoder.encode(i_Price, forKey: "i_price")
        }
        if i_Watch != nil{
            aCoder.encode(i_Watch, forKey: "i_watch")
        }
        if s_CarOwner != nil{
            aCoder.encode(s_CarOwner, forKey: "s_carOwner")
        }
        if ar_Color != nil{
            aCoder.encode(ar_Color, forKey: "ar_color")
        }
        if s_Company != nil{
            aCoder.encode(s_Company, forKey: "s_company")
        }
        if s_Description != nil{
            aCoder.encode(s_Description, forKey: "s_description")
        }
        if ar_Image != nil{
            aCoder.encode(ar_Image, forKey: "ar_Image")
        }
        if s_Rating != nil{
            aCoder.encode(s_Rating, forKey: "s_rating")
        }
        if s_Title != nil{
            aCoder.encode(s_Title, forKey: "s_title")
        }
        if s_Type != nil{
            aCoder.encode(s_Type, forKey: "s_type")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
