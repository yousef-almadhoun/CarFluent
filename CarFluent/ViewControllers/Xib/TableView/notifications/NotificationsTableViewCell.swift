//
//  NotificationsTableViewCell.swift
//  CarFluent
//
//  Created by mac on 12/12/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPerson: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblNotification: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    var object: Notifications?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimated()
    }
    
    func configureCell() {
        if let obj = self.object {
            self.imgPerson?.kf.indicatorType = .activity
            self.imgPerson?.kf.setImage(with: URL.init(string: obj.img ?? ""), placeholder: "bgProfilePlassholder".image_)
            self.imgPerson.contentMode = .scaleAspectFill
            self.imgPerson.clipsToBounds = true
            self.lblName.text = obj.name
            self.lblNotification.text = obj.notification
            self.lblDate.text = obj.date
        }
    }
    
}

extension NotificationsTableViewCell {
    
    func showAnimated() {
        self.imgPerson.showAnimatedGradientSkeleton()
        self.lblName.showAnimatedGradientSkeleton()
        self.lblNotification.showAnimatedGradientSkeleton()
        self.lblDate.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.imgPerson.hideSkeleton()
        self.lblName.hideSkeleton()
        self.lblNotification.hideSkeleton()
        self.lblDate.hideSkeleton()
    }
    
}
