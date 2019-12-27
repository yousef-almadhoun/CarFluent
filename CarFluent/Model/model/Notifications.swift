//
//  Notifications.swift
//  CarFluent
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class Notifications {
    
    var idNotifications: String?
    
    var idReservation: String?
    
    var img: String?
    
    var name: String?
    
    var notification: String?
    
    var date: String?
    
    init(idNotifications: String, idReservation: String, img: String, name: String, notification: String, date: String) {
        self.idNotifications = idNotifications
        self.idReservation = idReservation
        self.img = img
        self.name = name
        self.notification = notification
        self.date = date
    }
    
}
