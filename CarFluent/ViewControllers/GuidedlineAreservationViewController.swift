//
//  GuidedlineAreservationViewController.swift
//  CarFluent
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import BEMCheckBox

class GuidedlineAreservationViewController: UIViewController {

    @IBOutlet weak var chBox1: BEMCheckBox!
    
    @IBOutlet weak var chBox2: BEMCheckBox!
    
    var data: ReservationCarData?
    
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
    
    @IBAction func btnStartReservation(_ sender: Any) {
        guard chBox1.on && chBox2.on else {
            self.showAlertError(message: "Please Accept The Terms To Complete The Reservation Process!")
            return
        }
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AppointmentViewController") as! AppointmentViewController
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GuidedlineAreservationViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        chBox1.boxType = BEMBoxType.square
        chBox2.boxType = BEMBoxType.square
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}
