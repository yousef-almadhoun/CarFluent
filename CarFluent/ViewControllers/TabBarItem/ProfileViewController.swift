//
//  ProfileViewController.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewName: UIView!
    
    @IBOutlet weak var viewType: UIView!
    
    var listProfile: [profile] = [profile.notifications, profile.favourite, profile.payment, profile.logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
}

extension ProfileViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.register(UINib.init(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        self.imgProfile.contentMode = .scaleAspectFill
        self.imgProfile.clipsToBounds = true
        self.showAnimated()
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        FirebaseManager.shared.getUsers { (data) in
            for (_, value) in data.enumerated() {
                if value.udid == Auth.auth().currentUser?.uid {
                    self.hideAnimated()
                    self.imgProfile?.kf.indicatorType = .activity
                    self.imgProfile?.kf.setImage(with: URL.init(string: value.s_Image ?? ""), placeholder: "bgProfilePlassholder".image_)
                    self.lblName.text = value.s_Name
                    self.lblType.text = value.s_TypeUser
                    break
                }
            }
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell",  for: indexPath) as! ProfileTableViewCell
        let obj = self.listProfile[indexPath.row]
        cell.object = obj
        cell.configureCell()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == listProfile.count - 1 {
            if FirebaseManager.shared.signOut() {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "CarFluentViewController")
                AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
            }
        } else {
            let arr = ["NotificationsViewController", "FavouriteViewController", "PaymentViewController"]
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: arr[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ProfileViewController {
    
    func showAnimated() {
        self.imgProfile.showAnimatedGradientSkeleton()
        self.viewName.showAnimatedGradientSkeleton()
        self.viewType.showAnimatedGradientSkeleton()
        self.lblType.textColor = .white
    }
    
    func hideAnimated() {
        self.imgProfile.hideSkeleton()
        self.viewName.hideSkeleton()
        self.viewType.hideSkeleton()
        self.lblType.textColor = "#979797".color_
    }
    
}
