//
//  PaymentCollectionViewCell.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class PaymentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgPayment: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var object: String?
    
    func configureCell() {
        if let obj = self.object {
            self.bgPayment.image = obj.image_
        }
    }
    
}
