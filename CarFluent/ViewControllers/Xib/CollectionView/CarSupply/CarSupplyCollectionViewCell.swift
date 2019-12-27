//
//  CarSupplyCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class CarSupplyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCar: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }
    
    var object: CarSupply?
    
    func configureCell() {
        if let obj = self.object {
            self.imgCar?.kf.indicatorType = .activity
            self.imgCar?.kf.setImage(with: URL.init(string: obj.img ?? ""), placeholder: "imgSplash".image_)
            self.imgCar.contentMode = .scaleAspectFill
            self.imgCar.clipsToBounds = true
            self.lblName.text = obj.name?.uppercased()
            if let price = obj.price {
                self.lblPrice.text = "\(price)$ perDay"
            }
        }
    }

}

extension CarSupplyCollectionViewCell {
    
    func showAnimated() {
        lblName.text = ""
        lblPrice.text = ""
        self.imgCar.showAnimatedGradientSkeleton()
        self.lblName.showAnimatedGradientSkeleton()
        self.lblPrice.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.imgCar.hideSkeleton()
        self.lblName.hideSkeleton()
        self.lblPrice.hideSkeleton()
    }
    
}
