//
//  CarCategoryCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import SkeletonView

class CarCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblNameItem: UILabel!
    
    @IBOutlet weak var viewSelection: UIView!
    
    var indexPath: IndexPath?
    
    var object: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }

    func configureCell() {
        if let obj = self.object {
            lblNameItem.text = obj
        }
        if let parent = self.parentViewController as? CarItemViewController {
            self.selection(isSelected: parent.selectedCategoryItem == self.indexPath?.row)
        }
    }
}

extension CarCategoryCollectionViewCell {
    func selection(isSelected: Bool) {
        self.lblNameItem.font = isSelected ? UIFont.init(name: "Roboto", size: 20) : UIFont.init(name: "Roboto", size: 16)
        self.lblNameItem.alpha = isSelected ? 1 : 0.5
    }
    
}

extension CarCategoryCollectionViewCell {
    
    func showAnimated() {
        self.lblNameItem.text = ""
        self.lblNameItem.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.lblNameItem.hideSkeleton()
    }
    
}
