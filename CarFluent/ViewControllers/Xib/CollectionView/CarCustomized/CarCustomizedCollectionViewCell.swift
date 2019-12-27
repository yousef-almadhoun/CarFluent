//
//  CarCustomizedCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class CarCustomizedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var imgCar: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblOldPrice: UILabel!
    
    @IBOutlet weak var lblNewPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }

    var object: CarCustomize?
    
    func configureCell() {
        if let obj = self.object {
            self.imgCar?.kf.indicatorType = .activity
            self.imgCar?.kf.setImage(with: URL.init(string: obj.imgCar ?? ""), placeholder: "imgSplash".image_)
            self.imgCar.contentMode = .scaleAspectFill
            self.imgCar.clipsToBounds = true
            self.lblName.text = obj.name?.uppercased()
            if let newPrice = obj.newPrice, let oldPrice = obj.oldPrice {
                self.lblOldPrice.text = "\(oldPrice)$"
                self.lblNewPrice.text = "\(newPrice)$ perDay"
            }
        }
    }
}

extension CarCustomizedCollectionViewCell {
    
    func showAnimated() {
        self.imgCar.showAnimatedGradientSkeleton()
        self.lblName.showAnimatedGradientSkeleton()
        self.lblOldPrice.showAnimatedGradientSkeleton()
        self.lblNewPrice.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.6901960784, blue: 0.168627451, alpha: 1)
        self.imgCar.hideSkeleton()
        self.lblName.hideSkeleton()
        self.lblOldPrice.hideSkeleton()
        self.lblNewPrice.hideSkeleton()
    }
    
}
