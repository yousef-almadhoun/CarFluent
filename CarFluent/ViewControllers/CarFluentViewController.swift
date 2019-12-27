//
//  CarFluentViewController.swift
//  CarFluent
//
//  Created by mac on 10/29/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import Foundation

class CarFluentViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lblConntentsCar: UILabel!
    
    @IBOutlet weak var viewConntentsCar: UIView!
    
    var objects: [CarFluent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "PagerViewController") as! PagerViewController
        vc.showPagerTabStripViewController = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "PagerViewController") as! PagerViewController
        vc.showPagerTabStripViewController = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CarFluentViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionView.register(UINib.init(nibName: "CarFluentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarFluentCollectionViewCell")
        viewConntentsCar.showAnimatedGradientSkeleton()
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        FirebaseManager.shared.getCompanyData { (data) in
            for (_, value) in data.enumerated() {
                if self.objects == nil {
                    self.objects = []
                }
                self.objects?.append(CarFluent.init(carLogo: value.s_Image, nameCar: value.s_Name))
            }
            self.collectionView.reloadData()
            self.viewConntentsCar.hideSkeleton()
            self.lblConntentsCar.text = "\(data.count) COMPANY CONNTENTS CARS"
        }
    }
    
}

extension CarFluentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarFluentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarFluentCollectionViewCell",  for: indexPath) as! CarFluentCollectionViewCell
        if let object = objects {
            cell.hideAnimated()
            let obj = object[indexPath.row]
            cell.object = obj
            cell.configureCell()
        }
        
        return cell
    }
}

extension CarFluentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.size.width - 60) / 2
        let height: CGFloat = (UIScreen.main.bounds.size.height * 102) / 814
        return CGSize.init(width: width, height: height)
    }
}
