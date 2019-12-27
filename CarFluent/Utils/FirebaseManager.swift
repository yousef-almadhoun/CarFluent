//
//  FirebaseManager.swift
//  CarFluent
//
//  Created by mac on 12/2/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    let db = Database.database().reference().root
    
    func isUserLogin() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func getUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    func createUser(email: String, password: String, comletion: @escaping (_ sucess: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
                if let user = authResult?.user {
                    UserDefaults.standard.set(user.uid, forKey: "userId")
                }
                comletion(true)
            } else {
                comletion(false)
            }
        }
    }
    
    func addUserData(name: String, email: String, phoneNumber: String, image: String, typeUser: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let udid = UserDefaults.standard.string(forKey: "userId") ?? ""
        let dic: [String: Any] = ["udid": udid,
                                  "s_name": name,
                                  "s_email": email,
                                  "s_phoneNumber": phoneNumber,
                                  "s_image": image,
                                  "s_typeUser": typeUser
                              ]
        ref.child("TUser").child(udid).setValue(dic)
    }
    
    func login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _ = error {
                completion(false)
            } else if let _ = Auth.auth().currentUser {
                completion(true)
            }
        }
    }
    
    func getUsers(completion: @escaping (_ data: [TUser]) -> Void) {
        self.db.child("TUser").observe(.value) { (snapshot) in
            var userData: [TUser] = []
            let userDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, value) in userDic {
                if let value = value as? [String : AnyObject] {
                    let obj = TUser.init(fromDictionary: value)
                    userData.append(obj)
                }
            }
            completion(userData)
        }
    }
    
    func getCompanyData(completion: @escaping (_ data: [TCompany]) -> Void) {
        self.db.child("TCompany").observeSingleEvent(of: .value) { (snapshot) in
            var companyData: [TCompany] = []
            let companyDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, val) in companyDic {
                if let value = val as? [String : AnyObject] {
                    let obj = TCompany.init(fromDictionary: value)
                    companyData.append(obj)
                }
            }
            completion(companyData)
        }
    }
    
    func addCar(type: String, title: String, rating: String, description: String, company: String, carOwner: String, price: Int, image: [String], color: [String]) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let udid = ref.childByAutoId().key
        let dic: [String: Any] = ["udid": udid,
                                  "s_type": type,
                                  "s_title": title,
                                  "s_rating": rating,
                                  "s_description": description,
                                  "s_company": company,
                                  "s_carOwner": carOwner,
                                  "i_watch": 0,
                                  "i_price": price,
                                  "enable": true,
                                  "dt_create_at": Date().toString(customFormat: "yyyy-MM-dd"),
                                  "ar_image": image,
                                  "ar_color": color,
                                    ]
        ref.child("TCar").child(udid ?? "").setValue(dic)
    }
    
    func getCars(completion: @escaping (_ data: [TCar]) -> Void) {
        self.db.child("TCar").observeSingleEvent(of: .value) { (snapshot) in
            var carsData: [TCar] = []
            let carDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, val) in carDic {
                if let value = val as? [String : AnyObject] {
                    let obj = TCar.init(fromDictionary: value)
                    self.getImage(udid: obj.udid, completion: { (image) in
                        obj.ar_Image = image
                    })
                    self.getColor(udid: obj.udid, completion: { (color) in
                        obj.ar_Color = color
                    })
                    carsData.append(obj)
                }
            }
            completion(carsData)
        }
    }
    
    func getImage(udid: String, completion: @escaping (_ data: [String]) -> Void) {
        self.db.child("TCar").child(udid).child("ar_image").observe(.value) { (snapshot) in
            var imageData: [String] = []
            for key in 0..<Int(snapshot.childrenCount) {
                imageData.append(snapshot.childSnapshot(forPath: "\(key)").value as? String ?? "")
            }
            completion(imageData)
        }
    }
    
    func getColor(udid: String, completion: @escaping (_ data: [String]) -> Void) {
        self.db.child("TCar").child(udid).child("ar_color").observe(.value) { (snapshot) in
            var imageData: [String] = []
            for key in 0..<Int(snapshot.childrenCount) {
                imageData.append(snapshot.childSnapshot(forPath: "\(key)").value as? String ?? "")
            }
            completion(imageData)
        }
    }
    
    func addOffers(idCar: String, price: Int) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let udid = ref.childByAutoId().key
        let dic: [String: Any] = ["udid": udid,
                                  "s_id_car": idCar,
                                  "i_offer_price": price
        ]
        ref.child("TOffers").child(udid ?? "").setValue(dic)
    }
    
    func getOffers(completion: @escaping (_ data: [TOffers]) -> Void) {
        self.db.child("TOffers").observe(.value) { (snapshot) in
            var offersData: [TOffers] = []
            let offersDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, value) in offersDic {
                if let value = value as? [String : AnyObject] {
                    let obj = TOffers.init(fromDictionary: value)
                    offersData.append(obj)
                }
            }
            completion(offersData)
        }
    }
    
    func addHomeCollection(idCar: String, priority: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let udid = ref.childByAutoId().key
        let dic: [String: Any] = ["udid": udid,
                                  "s_id_car": idCar,
                                  "s_Priority": priority
        ]
        ref.child("THomeCollection").child(udid ?? "").setValue(dic)
    }
    
    func getHomeCollection(completion: @escaping (_ data: [THomeCollection]) -> Void) {
        self.db.child("THomeCollection").observe(.value) { (snapshot) in
            var collectionData: [THomeCollection] = []
            let collectionDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, value) in collectionDic {
                if let value = value as? [String : AnyObject] {
                    let obj = THomeCollection.init(fromDictionary: value)
                    collectionData.append(obj)
                }
            }
            completion(collectionData)
        }
    }

    func reservationCarData(idPerson: String, owner: String, location: String, timeTo: String, timeFrom: String, dateTo: String, dateFrom: String, idCar: String, carPrice: String, transmission: String, fuel: String, color: String, fuelRatio: String, paymentMethod: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let udid = ref.childByAutoId().key
        let dic: [String: Any] = ["udid": udid,
                                  "s_idPerson": idPerson,
                                  "s_owner": owner,
                                  "s_location": location,
                                  "s_timeTo": timeTo,
                                  "s_timeFrom": timeFrom,
                                  "s_dateTo": dateTo,
                                  "s_dateFrom": dateFrom,
                                  "s_idCar": idCar,
                                  "s_carPrice": carPrice,
                                  "s_transmission": transmission,
                                  "s_fuel": fuel,
                                  "color": color,
                                  "fuelRatio": fuelRatio,
                                  "paymentMethod": paymentMethod
        ]
        ref.child("TReservationCar").child(udid ?? "").setValue(dic)
        notifications(from: idPerson, idReservation: udid ?? "", to: owner, message: "Our Reprsentative")
    }
    
    func getReservation(completion: @escaping (_ data: [TReservationCar]) -> Void) {
        self.db.child("TReservationCar").observe(.value) { (snapshot) in
            var reservationData: [TReservationCar] = []
            let reservationDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, value) in reservationDic {
                if let value = value as? [String : AnyObject] {
                    let obj = TReservationCar.init(fromDictionary: value)
                    reservationData.append(obj)
                }
            }
            completion(reservationData)
        }
    }
    
    func deleteReservationCar(udid: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("TReservationCar").child(udid).setValue(nil)
    }
    
    func notifications(from: String, idReservation: String, to: String, message: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let udid = ref.childByAutoId().key
        let dic: [String: Any] = ["udid": udid,
                                  "s_from": from,
                                  "s_idReservation": idReservation,
                                  "s_to": to,
                                  "s_message": message,
                                  "b_isRead": false,
                                  "s_date": Date().toString(customFormat: "yyyy-MM-dd hh:mm a")
                                    ]
        ref.child("TNotifications").child(udid ?? "").setValue(dic)
    }
    
    func getNotifications(completion: @escaping (_ data: [TNotifications]) -> Void) {
        self.db.child("TNotifications").observeSingleEvent(of: .value) { (snapshot) in
            var notificationsData: [TNotifications] = []
            let notificationsDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, value) in notificationsDic {
                if let value = value as? [String : AnyObject] {
                    let obj = TNotifications.init(fromDictionary: value)
                    if obj.s_to == Auth.auth().currentUser?.uid {
                        notificationsData.append(obj)
                    }
                }
            }
            completion(notificationsData)
        }
    }
    
    func deleteNotifications(udid: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("TNotifications").child(udid).setValue(nil)
    }
    
    func addWatch(udid: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        self.getCars { (data) in
            for (_, value) in data.enumerated() {
                if udid == value.udid {
                    ref.child("TCar").child(udid).child("i_watch").setValue(value.i_Watch + 1)
                    break
                }
            }
        }
    }
    
    func addFavorite(udidUser: String, udidCar: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let udid = ref.childByAutoId().key
        let dic: [String: Any] = ["udid": udid,
                                  "s_idUser": udidUser,
                                  "s_idCar": udidCar
                                    ]
        ref.child("TFavorite").child(udid ?? "").setValue(dic)
    }
    
    func getFavorite(completion: @escaping (_ data: [TFavorite]) -> Void) {
        self.db.child("TFavorite").observeSingleEvent(of: .value) { (snapshot) in
            var favoriteData: [TFavorite] = []
            let favoriteDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, value) in favoriteDic {
                if let value = value as? [String : AnyObject] {
                    let obj = TFavorite.init(fromDictionary: value)
                    favoriteData.append(obj)
                }
            }
            completion(favoriteData)
        }
    }
    
    func deleteFavorite(udid: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("TFavorite").child(udid).setValue(nil)
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            
        }
        return false
    }
    
}
