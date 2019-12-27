//
//  ProfileTableViewCell.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var icImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var object: profile?
    
    func configureCell() {
        if let obj = self.object {
            self.lblTitle.text = obj.title
            self.icImage.image = obj.image.image_
        }
    }
    
}
