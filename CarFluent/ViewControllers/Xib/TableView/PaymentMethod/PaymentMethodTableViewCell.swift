//
//  PaymentMethodTableViewCell.swift
//  CarFluent
//
//  Created by mac on 11/23/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var lblPaymentTitle: UILabel!
    
    @IBOutlet weak var imgPayment: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var object: paymentMethod?
    
    func configureCell() {
        if let obj = self.object {
            self.lblPaymentTitle.text = obj.paymentTitle
            self.imgPayment.image = obj.paymentImg.image_
            if obj.paymentTitle.lowercased() == "cash" {
                view.backgroundColor = "#FFB02B".color_
                lblPaymentTitle.textColor = .hexColor(hex: "#FFFFFF")
            }
        }
    }
    
}
