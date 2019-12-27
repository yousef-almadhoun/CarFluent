//
//  FavouriteCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgCar: UIImageView!
    
    @IBOutlet weak var viewFavourite: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var viewRating: UIView!
    
    @IBOutlet weak var lblRate: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }

    var object: Favourite?
    
    func configureCell() {
        if let obj = self.object {
            self.bgCar?.kf.indicatorType = .activity
            self.bgCar?.kf.setImage(with: URL.init(string: obj.imgCar ?? ""), placeholder: "imgSplash".image_)
            self.bgCar.contentMode = .scaleAspectFill
            self.bgCar.clipsToBounds = true
            self.lblTitle.text = obj.title?.uppercased()
            self.lblDescription.text = obj.description
            self.lblRating.text = obj.rating
        }
    }
    
    @IBAction func btnFavourite(_ sender: Any) {
        if let parent = self.parentViewController as? FavouriteViewController {
            if let index = parent.objects?.firstIndex(where: { $0.idFavourite == self.object?.idFavourite}) {
                FirebaseManager.shared.deleteFavorite(udid: self.object?.idFavourite ?? "")
                parent.objects?.remove(at: index)
                parent.collectionView.reloadData()
            }
        }
    }
}

extension FavouriteCollectionViewCell {
    
    func showAnimated() {
        self.bgCar.showAnimatedGradientSkeleton()
        self.lblTitle.showAnimatedGradientSkeleton()
        self.lblDescription.showAnimatedGradientSkeleton()
        self.viewRating.isHidden = true
        self.viewFavourite.isHidden = true
        self.lblRate.isHidden = true
    }
    
    func hideAnimated() {
        self.bgCar.hideSkeleton()
        self.lblTitle.hideSkeleton()
        self.lblDescription.hideSkeleton()
        self.viewRating.isHidden = false
        self.viewFavourite.isHidden = false
        self.lblRate.isHidden = false
    }
    
}
