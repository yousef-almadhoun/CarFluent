//
//  UIViewExtensions.swift
//  Test1
//
//  Created by Mahmoud Abo-Osama on 9/8/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  @IBInspectable var isRounded: Bool {
      set {
        self.layer.cornerRadius = self.frame.height / 2
      }
      get {
          return self.layer.cornerRadius == self.frame.height / 2
      }
  }
    
//    @IBInspectable var borderColor: UIColor {
//        set {
//            self.layer.borderColor = newValue.cgColor
//        }
//        get {
//            return UIColor.init(cgColor: self.layer.borderColor ?? UIColor.white.cgColor)
//        }
//    }
//    
//    
//    @IBInspectable var shadowRadius: CGFloat {
//        set {
//            self.layer.shadowRadius = newValue
//        }
//        get {
//            return self.layer.shadowRadius
//        }
//    }
//    
//    @IBInspectable var shadowColor: UIColor {
//        set {
//            self.layer.shadowColor = newValue.cgColor
//        }
//        get {
//            return UIColor.init(cgColor: self.layer.shadowColor ?? UIColor.white.cgColor)
//        }
//    }
//    
//    @IBInspectable var shadowOffset: CGSize {
//        set {
//            self.layer.shadowOffset = newValue
//        }
//        get {
//            return self.layer.shadowOffset
//        }
//    }
//    
//    @IBInspectable var shadowOpacity: Float {
//        set {
//            self.layer.shadowOpacity = newValue
//        }
//        get {
//            return self.layer.shadowOpacity
//        }
//    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UITabBar {
    @IBInspectable var isShowOriginalColor: Bool {
        set {
            for (index, item) in (self.items ?? []).enumerated() {
                let img =  item.selectedImage?.withRenderingMode(.alwaysOriginal)
                self.items?[index].selectedImage = newValue == true ? img : item.selectedImage
            }
        } get {
            return false
        }
    }
    @IBInspectable var nonSelectionActionColor: UIColor {
        set {
            self.unselectedItemTintColor = newValue
        } get {
            return self.unselectedItemTintColor ?? .gray
        }
    }
}
