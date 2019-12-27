//
//  CollectionCarViewController.swift
//  CarFluent
//
//  Created by mac on 11/25/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CollectionCarViewController: UIViewController {

    @IBOutlet weak var carFiuentCollectionView: UICollectionView!
    
    @IBOutlet weak var carCollectionView: UICollectionView!
    
    var carFiuentData: [CarFluent]?
    
    var carData: [CollectionCar]?
    
    var selectedItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
}

extension CollectionCarViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        carFiuentCollectionView.register(UINib.init(nibName: "CarFluentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarFluentCollectionViewCell")
        carCollectionView.register(UINib.init(nibName: "CarWatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarWatchCollectionViewCell")
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        FirebaseManager.shared.getCars { (data) in
            for (_, value) in data.enumerated() {
                FirebaseManager.shared.getImage(udid: value.udid, completion: { (image) in
                    if self.carData == nil {
                        self.carData = []
                    }
                    self.carData?.append(CollectionCar.init(imgCar: image[0], watchCar: String(value.i_Watch)))
                    self.carCollectionView.reloadData()
                })
            }
        }
        
        FirebaseManager.shared.getCompanyData { (data) in
            for (_, value) in data.enumerated() {
                if self.carFiuentData == nil {
                    self.carFiuentData = []
                }
                self.carFiuentData?.append(CarFluent.init(carLogo: value.s_Image, nameCar: value.s_Name))
            }
            self.carFiuentCollectionView.reloadData()
        }
    }
    
}

extension CollectionCarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == carFiuentCollectionView {
            return carFiuentData?.count ?? 4
        } else {
            return carData?.count ?? 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carFiuentCollectionView {
            let cell: CarFluentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarFluentCollectionViewCell",  for: indexPath) as! CarFluentCollectionViewCell
            let obj = self.carFiuentData?[indexPath.row]
            cell.object = obj
            cell.configureCell()
            if let carFiuentData = carFiuentData {
                cell.hideAnimated()
                let obj = carFiuentData[indexPath.row]
                cell.object = obj
                cell.configureCell()
            }
            return cell
        } else {
            let cell: CarWatchCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarWatchCollectionViewCell",  for: indexPath) as! CarWatchCollectionViewCell
            collectionView.allowsSelection = false
            if let carData = carData {
                cell.hideAnimated()
                cell.indexPath = indexPath
                let obj = carData[indexPath.row]
                cell.object = obj
                cell.configureCell()
                collectionView.allowsSelection = true
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == carCollectionView {
            if selectedItem == nil || selectedItem != indexPath.row {
                self.selectedItem = indexPath.row
            }
            carCollectionView.reloadData()
        }
    }
}

extension CollectionCarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == carCollectionView {
            if indexPath.row % 6 == 0 && carData?.count ?? 0 % 2 != 0 && indexPath.row != 0 {
                let width: CGFloat = UIScreen.main.bounds.size.width - 40
                let height: CGFloat = width * (120/150)
                return CGSize.init(width: width, height: height)
            } else {
                let width: CGFloat = (UIScreen.main.bounds.size.width - 50) / 2
                let height: CGFloat = width * (130/150)
                return CGSize.init(width: width, height: height)
            }
        } else {
            let width: CGFloat = (UIScreen.main.bounds.size.width - 60) / 4
            let height: CGFloat = (UIScreen.main.bounds.size.height * 102) / 1091
            return CGSize.init(width: width, height: height)
        }
    }
}
