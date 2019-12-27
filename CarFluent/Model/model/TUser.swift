//
//  TUser.swift
//  CarFluent
//
//  Created by mac on 12/2/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class TUser : NSObject, NSCoding {
    
    var s_Email : String!
    var s_Image : String!
    var s_Name : String!
    var s_PhoneNumber : String!
    var s_TypeUser : String!
    var udid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        s_Email = dictionary["s_email"] as? String
        s_Image = dictionary["s_image"] as? String
        s_Name = dictionary["s_name"] as? String
        s_PhoneNumber = dictionary["s_phoneNumber"] as? String
        s_TypeUser = dictionary["s_typeUser"] as? String
        udid = dictionary["udid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if s_Email != nil{
            dictionary["s_email"] = s_Email
        }
        if s_Image != nil{
            dictionary["s_image"] = s_Image
        }
        if s_Name != nil{
            dictionary["s_name"] = s_Name
        }
        if s_PhoneNumber != nil{
            dictionary["s_phoneNumber"] = s_PhoneNumber
        }
        if s_TypeUser != nil{
            dictionary["s_typeUser"] = s_TypeUser
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
        s_Email = aDecoder.decodeObject(forKey: "s_email") as? String
        s_Image = aDecoder.decodeObject(forKey: "s_image") as? String
        s_Name = aDecoder.decodeObject(forKey: "s_name") as? String
        s_PhoneNumber = aDecoder.decodeObject(forKey: "s_phoneNumber") as? String
        s_TypeUser = aDecoder.decodeObject(forKey: "s_typeUser") as? String
        udid = aDecoder.decodeObject(forKey: "udid") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if s_Email != nil{
            aCoder.encode(s_Email, forKey: "s_email")
        }
        if s_Image != nil{
            aCoder.encode(s_Image, forKey: "s_image")
        }
        if s_Name != nil{
            aCoder.encode(s_Name, forKey: "s_name")
        }
        if s_PhoneNumber != nil{
            aCoder.encode(s_PhoneNumber, forKey: "s_phoneNumber")
        }
        if s_TypeUser != nil{
            aCoder.encode(s_TypeUser, forKey: "s_typeUser")
        }
        if udid != nil{
            aCoder.encode(udid, forKey: "udid")
        }
    }
}
