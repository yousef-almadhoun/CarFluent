//
//  AppointmentViewController.swift
//  CarFluent
//
//  Created by mac on 11/13/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AppointmentViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var imgForward: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var location: String?
    
    var timeTo: String?
    
    var timeFrom: String?
    
    var dateTo: String?

    var dateFrom: String?
    
    var idCar: String?
    
    var carPrice: String?
    
    var data: ReservationCarData?
    
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
        if currentIndex == 0 {
            return
        }
        moveToViewController(at: currentIndex - 1)
        changeTitle(index: currentIndex - 1)
        changeColorButton(index: currentIndex - 1)
    }
    
    @IBAction func btnForward(_ sender: Any) {
        if currentIndex == 2 {

            guard let location = self.location else {
                showAlertError(message: "Please Enter The Location Of Receipt Of The Car!")
                moveToViewController(at: 0)
                return
            }
            
            guard let dateTo = self.dateTo, let dateFrom = self.dateFrom else {
                showAlertError(message: "Please Enter The Date Of Receipt Of The Car!")
                moveToViewController(at: 1)
                return
            }

            guard let timeTo = self.timeTo, let timeFrom = self.timeFrom else {
                showAlertError(message: "Please Enter The Time Of Receipt Of The Car!")
                moveToViewController(at: 2)
                return
            }
            
            data?.location = location
            data?.dateFrom = dateFrom
            data?.dateTo = dateTo
            data?.timeFrom = timeFrom
            data?.timeTo = timeTo
            
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "PaymentMethodViewController") as! PaymentMethodViewController
            vc.data = data
            self.navigationController?.pushViewController(vc, animated: true)
            
            return

        }
        moveToViewController(at: currentIndex + 1)
        changeTitle(index: currentIndex + 1)
        changeColorButton(index: currentIndex + 1)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "LocationViewController")
        let child_2 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "DateViewController")
        let child_3 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TimeViewController")
        return [child_1, child_2, child_3]
    }
    
}

extension AppointmentViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        changeTitle(index: currentIndex)
        changeColorButton(index: currentIndex)
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarHeight = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = "#D2D2D2".color_
            oldCell?.label.font = UIFont.init(name: "FontAwesome5FreeSolid", size: 25.0)
            newCell?.label.textColor = "#FFB02B".color_
            newCell?.label.font = UIFont.init(name: "FontAwesome5FreeSolid", size: 25.0)
        }
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}

extension AppointmentViewController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        changeTitle(index: currentIndex)
        changeColorButton(index: currentIndex)
    }
}

extension AppointmentViewController {
    
    func changeTitle(index: Int) {
        if index == 0 {
            lblTitle.text = "Choose Location".uppercased()
        } else if index == 1 {
            lblTitle.text = "Choose Date".uppercased()
        } else if index == 2 {
            lblTitle.text = "Choose Time".uppercased()
        }
    }
    
    func changeColorButton(index: Int) {
        if index == 0 {
            imgBack.tintColor = "#D2D2D2".color_
        } else if index == 2 {
            imgForward.tintColor = "#D2D2D2".color_
        } else {
            imgBack.tintColor = "#FF0000".color_
            imgForward.tintColor = "#000000".color_
        }
    }
    
}
