//
//  SignUpViewController.swift
//  CarFluent
//
//  Created by mac on 10/29/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import iOSDropDown
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var dropDown: DropDown!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var imgShowPassword: UIImageView!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var showLoader: Bool = false {
        didSet {
            self.indicator.isHidden = !showLoader
            self.btnSignUp.isEnabled = !showLoader
        }
    }
    
    var code: String?
    
    enum showPassword {
        case showPassword
        case hidePassword
    }
    
    var typeShowPassword: showPassword = .hidePassword {
        didSet {
            showOrHidePassword()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    @IBAction func btnShowPassword(_ sender: Any) {
        if typeShowPassword == .showPassword {
            typeShowPassword = .hidePassword
        } else {
            typeShowPassword = .showPassword
        }
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        if txtName.text?.isEmpty ?? false || txtEmail.text?.isEmpty ?? false || dropDown.selectedIndex == nil || txtPhoneNumber.text?.isEmpty ?? false || txtPassword.text?.isEmpty ?? false {
            showAlertError(message: "Please Fill In All Fields")
            return
        }
        
        guard txtEmail.text?.isValidEmail() ?? false else {
            showAlertError(message: "Please Enter A Valid Email Address")
            return
        }
        
        guard txtPhoneNumber.text?.isValidPhone() ?? false else {
            showAlertError(message: "Please Enter A Valid Phone Number")
            return
        }
        
        guard txtPassword.text?.isValidPassword() ?? false else {
            showAlertError(message: "Please enter a password that is more than 8 or less than 15")
            return
        }
        
        self.showLoader = true
        FirebaseManager.shared.createUser(email: txtEmail.text ?? "", password: txtPassword.text ?? "") { (success) in
            if success {
                FirebaseManager.shared.addUserData(name: self.txtName.text ?? "", email: self.txtEmail.text ?? "", phoneNumber: self.phoneNumber(), image: "", typeUser: "customer")
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showAlertError(message: "This Email Is Not Available!\n Please Enter Email Address")
            }
            self.showLoader = false
        }
    }
}

extension SignUpViewController {
    
    func setupView() {
        self.typeShowPassword = .hidePassword
        dropDown.checkMarkEnabled = false
        dropDown.selectedRowColor = "#dddddd".color_
        dropDown.isSearchEnable = false
        self.showLoader = false
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

extension SignUpViewController {
    func showOrHidePassword() {
        switch self.typeShowPassword {
            case .showPassword:
                txtPassword.isSecureTextEntry = false
                imgShowPassword.image = "icShowPassword".image_
                break
            case .hidePassword:
                txtPassword.isSecureTextEntry = true
                imgShowPassword.image = "icHidePassword".image_
            break
        }
    }
}

extension SignUpViewController {
    func phoneNumber() -> String {
        let numberPhone = self.txtPhoneNumber.text?.suffix(9)
        if let code = self.code, let number = numberPhone {
            return "\(code)\(number)"
        }
        return ""
    }
}

extension SignUpViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if let parent = self.parent as? PagerViewController {
            pagerTabStripController.moveToViewController(at: parent.showPagerTabStripViewController ?? 1, animated: false)
        }
        return IndicatorInfo(title: "Sign Up")
    }
}
