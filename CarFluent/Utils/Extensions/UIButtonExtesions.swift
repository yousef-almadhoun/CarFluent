//
//  UIButtonExtesions.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 9/26/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable var imageTinitColor: UIColor {
        set {
            let img = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.setImage(img, for: .normal)
            self.tintColor = newValue
        } get {
            return self.tintColor
        }
    }
}
