//
//  PaymentSuccessfulViewController.swift
//  CarFluent
//
//  Created by mac on 11/14/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class PaymentSuccessfulViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
