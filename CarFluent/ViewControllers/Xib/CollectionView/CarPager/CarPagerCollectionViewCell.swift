//
//  CarPagerCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class CarPagerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCar: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var viewButton: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }
    
    
    var object: CarPager?
    
    func configureCell() {
        if let obj = self.object {
            self.imgCar?.kf.indicatorType = .activity
            self.imgCar?.kf.setImage(with: URL.init(string: obj.imgCar ?? ""), placeholder: "imgSplash".image_)
            self.imgCar.contentMode = .scaleAspectFill
            self.imgCar.clipsToBounds = true
            self.lblName.text = obj.name
        }
    }
    
    @IBAction func btnGo(_ sender: Any) {
        if let parent = self.parentViewController as? HomeViewController {
            if parent.carModelsData?.firstIndex(where: { $0.idCar == self.object?.idCar }) != nil {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "StartAreservationViewController") as! StartAreservationViewController
                vc.data = ReservationCarData.init(idPerson: "", owner: "", company: "", type: "", location: "", timeTo: "", timeFrom: "", dateTo: "", dateFrom: "", idCar: "", carPrice: "", transmission: "", fuel: "", color: "", fuelRatio: "", paymentMethod: "")
                vc.data?.idCar = self.object?.idCar
                vc.data?.carPrice = self.object?.price
                parent.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

extension CarPagerCollectionViewCell {
    
    func showAnimated() {
        self.imgCar.showAnimatedGradientSkeleton()
        self.lblName.showAnimatedGradientSkeleton()
        self.viewButton.isHidden = true
    }
    
    func hideAnimated() {
        self.imgCar.hideSkeleton()
        self.lblName.hideSkeleton()
        self.viewButton.isHidden = false
    }
    
}
