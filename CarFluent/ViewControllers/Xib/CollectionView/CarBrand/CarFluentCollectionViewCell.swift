//
//  CarFluentCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 10/29/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class CarFluentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCarLogo: UIImageView!
    
    @IBOutlet weak var lblCarName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }
    
    var object: CarFluent?
    
    func configureCell() {
        if let obj = self.object {
            self.imgCarLogo?.kf.indicatorType = .activity
            self.imgCarLogo?.kf.setImage(with: URL.init(string: obj.carLogo ?? ""), placeholder: "imgSplash".image_)
            self.imgCarLogo.contentMode = .scaleAspectFit
            self.imgCarLogo.clipsToBounds = true
            self.imgCarLogo.image = obj.carLogo?.image_
            self.lblCarName.text = obj.nameCar
        }
    }
}

extension CarFluentCollectionViewCell {
    
    func showAnimated() {
        self.imgCarLogo.showAnimatedGradientSkeleton()
        self.lblCarName.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.imgCarLogo.hideSkeleton()
        self.lblCarName.hideSkeleton()
    }
    
}
