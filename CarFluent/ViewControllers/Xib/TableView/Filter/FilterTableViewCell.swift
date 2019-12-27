//
//  FilterTableViewCell.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var object: String?
    
    func configureCell() {
        if let obj = self.object {
            self.lblTitle.text = obj
        }
        if let parent = self.parentViewController as? FilterViewController {
            self.selection(isSelected: parent.selectedItem == self.indexPath?.row)
        }
    }
    
}

extension FilterTableViewCell {
    func selection(isSelected: Bool) {
        self.lblTitle.textColor = isSelected ? UIColor.hexColor(hex: "#FFB02B") : .black
    }
}
