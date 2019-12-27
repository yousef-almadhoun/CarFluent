//
//  ForgotPasswordViewController.swift
//  CarFluent
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import iOSDropDown

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var dropDown: DropDown!
    
    @IBOutlet weak var txtNumberPhone: UITextField!
    
    var code: String?
    
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
    
    @IBAction func btnSend(_ sender: Any) {
        if txtNumberPhone.text?.isValidPhone() ?? false {
            if dropDown.selectedIndex != nil {
                
            } else {
                showAlertError(message: "Please Select The International Number")
            }
        } else if txtNumberPhone.text?.isValidEmail() ?? false {
            
        } else {
            showAlertError(message: "Please Check Your Email Or Phone Number")
            return
        }
    }
    
}

extension ForgotPasswordViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func localized() {
        
    }
    
    func setupData() {
        dropDown.didSelect { (selectedText, index, id) in
            self.code = selectedText
        }
    }
    
    func fetchData() {
        GetPhoneNumberCodeAPI.shared.phoneNumberCode { (data) in
            self.dropDown.optionArray = data
        }
    }
    
}

extension ForgotPasswordViewController {
    func phoneNumber() -> String {
        let numberPhone = self.txtNumberPhone.text?.suffix(9)
        if let code = self.code, let number = numberPhone {
            return "\(code)\(number)"
        }
        return ""
    }
}
