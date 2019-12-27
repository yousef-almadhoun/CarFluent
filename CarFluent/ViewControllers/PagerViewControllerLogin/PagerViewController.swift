//
//  LoginOrRegisterViewController.swift
//  CarFluent
//
//  Created by mac on 10/29/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PagerViewController: ButtonBarPagerTabStripViewController {
    
    var showPagerTabStripViewController: Int?
    
    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        localized()
        setupData()
        fetchData()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SignInViewController")
        let child_2 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SignUpViewController")
        return [child_1, child_2]
    }

}

extension PagerViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = "#FFB02B".color_
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarItemFont = UIFont.init(name: "Roboto", size: 16) ?? .boldSystemFont(ofSize: 16)
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = "#FFB02B".color_
        }
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}
