//
//  CarWatchCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/25/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class CarWatchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgCar: UIImageView!
    
    @IBOutlet weak var lblWatch: UILabel!
    
    @IBOutlet weak var viewWatch: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
        viewWatch.isHidden = true
    }

    var indexPath: IndexPath?
    
    var object: CollectionCar?
    
    func configureCell() {
        if let obj = self.object {
            self.bgCar?.kf.indicatorType = .activity
            self.bgCar?.kf.setImage(with: URL.init(string: obj.imgCar ?? ""), placeholder: "imgSplash".image_)
            self.bgCar.contentMode = .scaleAspectFill
            self.bgCar.clipsToBounds = true
            if let watch = obj.watchCar {
                self.lblWatch.text = "\(watch) Users"
            }
            if let parent = self.parentViewController as? CollectionCarViewController {
                self.selection(isSelected: parent.selectedItem == self.indexPath?.row)
            }
        }
    }
    
}

extension CarWatchCollectionViewCell {
    func selection(isSelected: Bool) {
        self.viewWatch.isHidden = isSelected ? false : true
    }
}

extension CarWatchCollectionViewCell {
    
    func showAnimated() {
        self.bgCar.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.bgCar.hideSkeleton()
    }
    
}
