//
//  UIViewContollerExtensions.swift
//  Test1
//
//  Created by Mahmoud Abo-Osama on 9/12/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertPopUp(title: String, message: String, buttonTitle1: String = "OK", buttonTitle2: String = "Cancel", buttonTitle1Style: UIAlertAction.Style = .default, buttonTitle2Style: UIAlertAction.Style = .default, action1 buttonTitle1Action: @escaping (() -> Void), action2 buttonTitle2Action: @escaping (()->Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let button1 = UIAlertAction.init(title: buttonTitle1, style: buttonTitle1Style) { (action) in
            print("\(buttonTitle1) Button")
            buttonTitle1Action()
        }
        let button2 = UIAlertAction.init(title: buttonTitle2, style: buttonTitle2Style) { (action) in
            print("\(buttonTitle2) Button")
            buttonTitle2Action()
        }
        alert.addAction(button1)
//        alert.addAction(button2)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showAlertError(message: String) {
        self.showAlertPopUp(title: "Error", message: message, action1: {
        }) {
        }
    }
}
