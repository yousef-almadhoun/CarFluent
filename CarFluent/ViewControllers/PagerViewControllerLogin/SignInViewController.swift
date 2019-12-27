//
//  SignInViewController.swift
//  CarFluent
//
//  Created by mac on 10/29/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var imgShowPassword: UIImageView!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var showLoader: Bool = false {
        didSet {
            self.indicator.isHidden = !showLoader
            self.btnSignIn.isEnabled = !showLoader
        }
    }
    
    enum showPassword {
        case showPassword
        case hidePassword
    }
    
    var typeShowPassword: showPassword = .hidePassword {
        didSet {
            showOrHidePassword()
        }
    }
    
    var dataUser: [TUser] = []
    
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
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        if txtEmail.text?.isEmpty ?? false || txtPassword.text?.isEmpty ?? false {
            showAlertError(message: "Please Fill In All Fields")
            return
        }
        
        guard txtEmail.text?.isValidEmail() ?? false else {
            showAlertError(message: "Please Enter A Valid Email Address")
            return
        }
        
        guard txtPassword.text?.isValidPassword() ?? false else {
            showAlertError(message: "Please enter a password that is more than 8 or less than 15")
            return
        }
        self.showLoader = true
        FirebaseManager.shared.login(email: txtEmail.text ?? "", password: txtPassword.text ?? "") { (success) in
            if success {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showAlertError(message: "Please Check The Data Entered!")
            }
            self.showLoader = false
        }
        
    }
    
    @IBAction func btnLoginFacebook(_ sender: Any) {
        
    }
    
    @IBAction func btnLoginGoogle(_ sender: Any) {
        
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if let parent = self.parent as? PagerViewController {
            parent.moveToViewController(at: 1)
        }
    }
    
}

extension SignInViewController {
    
    func setupView() {
        self.typeShowPassword = .hidePassword
        showLoader = false
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        /*
         * Get Data User
         */
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userRef = ref.child("TUser")
        userRef.observe(DataEventType.value, with: { (snapshot) in
            let userDic = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, value) in userDic {
                if let value = value as? [String : AnyObject] {
                    let obj = TUser.init(fromDictionary: value)
                    self.dataUser.append(obj)
                }
            }
        })
    }
    
}

extension SignInViewController {
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

extension SignInViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if let parent = self.parent as? PagerViewController {
            pagerTabStripController.moveToViewController(at: parent.showPagerTabStripViewController ?? 0, animated: false)
        }
        return IndicatorInfo(title: "Sign In")
    }
}
