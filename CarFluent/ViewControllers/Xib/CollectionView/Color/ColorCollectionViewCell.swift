//
//  ColorCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import SkeletonView

class ColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var imgSelected: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSelected.isHidden = true
    }

    var indexPath: IndexPath?
    
    var object: String?
    
    func configureCell() {
        if let obj = self.object {
            self.colorView.backgroundColor = .hexColor(hex: obj)
            if let parent = self.parentViewController as? ModelsViewController {
                self.selection(isSelected: parent.selectedItem == self.indexPath?.row)
            }
        }
    }
}

extension ColorCollectionViewCell {
    func selection(isSelected: Bool) {
        self.imgSelected.isHidden = isSelected ? false : true
    }
}
