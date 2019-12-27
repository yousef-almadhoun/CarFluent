//
//  YourRecepitViewController.swift
//  CarFluent
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation
import UIKit

class YourRecepitViewController: UIViewController {

    @IBOutlet weak var imgCar: UIImageView!
    
    @IBOutlet weak var lblCarType: UILabel!
    
    @IBOutlet weak var lblLocationTo: UILabel!
    
    @IBOutlet weak var lblDateTo: UILabel!
    
    @IBOutlet weak var lblTimeTo: UILabel!
    
    @IBOutlet weak var lblLocationFrom: UILabel!
    
    @IBOutlet weak var lblDateFrom: UILabel!
    
    @IBOutlet weak var lblTimeFrom: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    var idReservation: String?
    
    var idCustomer: String?
    
    var idDealer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAccept(_ sender: Any) {
        FirebaseManager.shared.notifications(from: idDealer ?? "", idReservation: "", to: idCustomer ?? "", message: "The Request Has Been Approved")
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
        FirebaseManager.shared.deleteReservationCar(udid: idReservation ?? "")
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    @IBAction func btnRefusal(_ sender: Any) {
        FirebaseManager.shared.notifications(from: idCustomer ?? "", idReservation: "", to: idDealer ?? "", message: "The Request Was Rejected")
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
        FirebaseManager.shared.deleteReservationCar(udid: idReservation ?? "")
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}

extension YourRecepitViewController {
    
    func setupView() {
        
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        FirebaseManager.shared.getReservation { (data) in
            for (_, value) in data.enumerated() {
                if value.udid == self.idReservation {
                    self.imgCar.image = "bgCarSupply".image_
                    self.lblCarType.text = ""
                    self.lblLocationTo.text = value.sLocation
                    self.lblDateTo.text = value.sDateTo
                    self.lblTimeTo.text = value.sTimeTo
                    self.lblLocationFrom.text = value.sLocation
                    self.lblDateFrom.text = value.sDateFrom
                    self.lblTimeFrom.text = value.sTimeFrom
                    if let price = value.sCarPrice {
                        self.lblPrice.text = "\(price)$"
                    }
                    self.idDealer = value.sOwner
                    self.idCustomer = value.sIdPerson
                    FirebaseManager.shared.getImage(udid: value.sIdCar, completion: { (images) in
                        self.imgCar?.kf.indicatorType = .activity
                        self.imgCar?.kf.setImage(with: URL.init(string: images[0]), placeholder: "imgSplash".image_)
                        self.imgCar.contentMode = .scaleAspectFill
                        self.imgCar.clipsToBounds = true
                    })
                }
            }
        }
    }
    
}
