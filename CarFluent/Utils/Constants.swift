//
//  Constants.swift
//  CarFluent
//
//  Created by mac on 10/26/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

enum board {
    
    case board_1
    case board_2
    case board_3
    case board_4
    
    var title: String {
        switch self {
        case .board_1:
            return "Rental principle"
        case .board_2:
            return "How to rent a car"
        case .board_3:
            return "Waiting for the car"
        case .board_4:
            return "To Save More Money"
        }
    }
    
    var description: String {
        switch self {
        case .board_1:
            return "The best way to get the car you need at a price that suits you is to plan ahead and book in advance"
        case .board_2:
            return "You will need to consider pick up locations in the sense that you want to pick up your car for your trip."
        case .board_3:
            return "You Will Find Plenty Of Car Hire Desks At The Airport, Which Is Very Convenient But Often Cost More."
        case .board_4:
            return "To Save More Money You Might Want To That Consider Receiving A Rental Car - You Can Also Say Hire Car"
        }
        
    }
    
}

enum paymentMethod {
    
    case paypal
    case crediteCard
    case masterCard
    case visaCard
    case cash
    
    var paymentTitle: String {
        switch self {
            case .paypal:
                return "Pay Pal"
            case .crediteCard:
                return "Credite Card"
            case .masterCard:
                return "Master Card"
            case .visaCard:
                return "Visa Card"
            case .cash:
                return "Cash"
        }
    }
    
    var paymentImg: String {
        switch self {
            case .paypal:
                return "icPayPal"
            case .crediteCard:
                return "icCrediteCard"
            case .masterCard:
                return "icMastercard"
            case .visaCard:
                return "icVisa"
            case .cash:
                return ""
        }
    }
    
}

enum profile {
    
    case notifications
    case favourite
    case car
    case payment
    case logout
    
    var title: String {
        switch self {
            case .notifications:
                return "Notifications"
            case .favourite:
                return "Favourite"
            case .car:
                return "Car"
            case .payment:
                return "Payment"
            case .logout:
                return "Logout"
        }
    }
    
    var image: String {
        switch self {
            case .notifications:
                return "icNotifications"
            case .favourite:
                return "icFavoriteNotSelected"
            case .car:
                return "icCarProfile"
            case .payment:
                return "icPaymentProfile"
            case .logout:
                return "icLogout"
        }
    }
    
}

enum sortBy {
    
    case heightRating
    case closting
    case heightCost
    case lowCost
    case mostFamouse
    
    var sort: String {
        switch self {
            case .heightRating:
                return "Height Rating"
            case .closting:
                return "Closting"
            case .heightCost:
                return "Height Cost"
            case .lowCost:
                return "Low Cost"
            case .mostFamouse:
                return "Most Famouse"
        }
    }
}

enum filterBy {
    
    case acceptPayment
    case openNow
    
    var filter: String {
        switch self {
            case .acceptPayment:
                return "Accept Electronic Payment"
            case .openNow:
                return "Open Now"
        }
    }
}

enum transmission {
    
    case manual
    case automatic
    
    var transmissionTitle: String? {
        switch self {
            case .manual:
                return "Manual"
            case .automatic:
                return "Automatic"
        }
    }
}

enum fuel {
    
    case gasoline
    case solar
    
    var fuelTitle: String? {
        switch self {
        case .gasoline:
            return "Gasoline"
        case .solar:
            return "Solar"
        }
    }
}

