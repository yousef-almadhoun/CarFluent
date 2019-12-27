//
//  MainNavigationViewController.swift
//  CarFluent
//
//  Created by mac on 12/1/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
}

extension MainNavigationViewController {
    
    func setupView() {
        AppDelegate.shared.rootNavigationViewController = self
        if (UserDefaults.standard.object(forKey: "key") == nil) {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "BoardViewController")
            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
        } else if FirebaseManager.shared.isUserLogin() {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
        } else {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "CarFluentViewController")
            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
        }
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}
