//
//  CarCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }
    
    var object: String?
    
    func configureCell() {
        if let obj = self.object {
            self.imgCar?.kf.indicatorType = .activity
            self.imgCar?.kf.setImage(with: URL.init(string: obj ?? ""), placeholder: "imgSplash".image_)
            self.imgCar.contentMode = .scaleAspectFill
            self.imgCar.clipsToBounds = true
        }
    }

}

extension CarCollectionViewCell {
    
    func showAnimated() {
        self.imgCar.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.imgCar.hideSkeleton()
    }
    
}

