//
//  SearchTableViewCell.swift
//  CarFluent
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import FloatRatingView

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCar: UIImageView!
    
    @IBOutlet weak var lblOwner: UILabel!
    
    @IBOutlet weak var lblCompany: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblWatch: UILabel!
    
    @IBOutlet weak var rating: FloatRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.showAnimated()
        
    }
    
    var object: Search?
    
    func configureCell() {
        if let obj = self.object {
            self.imgCar?.kf.indicatorType = .activity
            self.imgCar?.kf.setImage(with: URL.init(string: obj.image ?? ""), placeholder: "imgSplash".image_)
            self.imgCar.contentMode = .scaleAspectFill
            self.imgCar.clipsToBounds = true
            self.lblOwner.text = obj.owner
            self.lblCompany.text = obj.company
            self.lblType.text = obj.type
            self.lblPrice.text = obj.price
            self.lblWatch.text = obj.watch
            self.rating.rating = obj.rating as? Double ?? 5.0
        }
    }
    
}

extension SearchTableViewCell {
    
    func showAnimated() {
        self.imgCar.showAnimatedGradientSkeleton()
        self.lblOwner.showAnimatedGradientSkeleton()
        self.lblCompany.showAnimatedGradientSkeleton()
        self.lblType.showAnimatedGradientSkeleton()
        self.lblPrice.showAnimatedGradientSkeleton()
        self.lblWatch.showAnimatedGradientSkeleton()
        self.rating.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.imgCar.hideSkeleton()
        self.lblOwner.hideSkeleton()
        self.lblCompany.hideSkeleton()
        self.lblType.hideSkeleton()
        self.lblPrice.hideSkeleton()
        self.lblWatch.hideSkeleton()
        self.rating.hideSkeleton()
    }
    
}
