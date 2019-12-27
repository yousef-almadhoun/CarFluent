//
//  CarItemViewController.swift
//  CarFluent
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import Foundation

class CarItemViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var carCollectionView: UICollectionView!
    
    @IBOutlet weak var emptyCar: UIView!
    
    var categoryItem: [Category]?
    
    var carSupply: [CarSupply]?
    
    var selectedCategoryItem: Int?
    
    var selectedCategory: String? {
        didSet {
            self.getCar()
        }
    }
    
    var num: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }

}

extension CarItemViewController {
    
    func setupView() {
        categoryCollectionView.register(UINib.init(nibName: "CarCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCategoryCollectionViewCell")
        carCollectionView.register(UINib.init(nibName: "CarSupplyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarSupplyCollectionViewCell")
    }
    
    func localized() {
        
    }
    
    func setupData() {

    }
    
    func fetchData() {
        self.categoryItem?.removeAll()
        FirebaseManager.shared.getUsers { (data) in
            for (_, value) in data.enumerated() {
                if value.s_TypeUser == "dealer" {
                    if self.categoryItem == nil {
                        self.categoryItem = []
                    }
                    self.categoryItem?.append(Category.init(id: value.udid, name: value.s_Name))
                }
            }
            self.categoryCollectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.selectedCategoryItem = 0
                self.selectedCategory = self.categoryItem?[0].id
                self.categoryCollectionView.reloadData()
            }
        }
    }
    
}

extension CarItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoryItem?.count ?? 5
        } else {
            if carSupply?.count == 0 {
                emptyCar.isHidden = false
            } else {
                emptyCar.isHidden = true
            }
            return carSupply?.count ?? num ?? 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCategoryCollectionViewCell", for: indexPath) as! CarCategoryCollectionViewCell
            collectionView.allowsSelection = false
            if let categoryItem = categoryItem {
                cell.hideAnimated()
                cell.indexPath = indexPath
                let obj = categoryItem[indexPath.row].name
                cell.object = obj
                cell.configureCell()
                collectionView.allowsSelection = true
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarSupplyCollectionViewCell", for: indexPath) as! CarSupplyCollectionViewCell
            collectionView.allowsSelection = false
            if let carSupply = carSupply {
                cell.hideAnimated()
                let obj = carSupply[indexPath.row]
                cell.object = obj
                cell.configureCell()
                collectionView.allowsSelection = true
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if selectedCategoryItem == nil || selectedCategoryItem != indexPath.row {
                self.selectedCategoryItem = indexPath.row
                self.selectedCategory = self.categoryItem?[indexPath.row].id
            }
            collectionView.reloadData()
        } else {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "StartAreservationViewController") as! StartAreservationViewController
            vc.data = ReservationCarData.init(idPerson: "", owner: "", company: "", type: "", location: "", timeTo: "", timeFrom: "", dateTo: "", dateFrom: "", idCar: "", carPrice: "", transmission: "", fuel: "", color: "", fuelRatio: "", paymentMethod: "")
            vc.data?.idCar = carSupply?[indexPath.row].id
            vc.data?.carPrice = carSupply?[indexPath.row].price
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CarItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let width: CGFloat = 90
            let height: CGFloat = 25
            return CGSize.init(width: width, height: height)
        } else {
            let width: CGFloat = (UIScreen.main.bounds.size.width - 40) / 2
            let height: CGFloat = 192
            return CGSize.init(width: width, height: height)
        }
    }
}

extension CarItemViewController {
    func getCar() {
        self.carSupply?.removeAll()
        FirebaseManager.shared.getCars { (data) in
            self.num = 0
            for (_, value) in data.enumerated() {
                if value.s_CarOwner == self.selectedCategory {
                    FirebaseManager.shared.getImage(udid: value.udid, completion: { (images) in
                        if self.carSupply == nil {
                            self.carSupply = []
                        }
                        self.carSupply?.append(CarSupply.init(id: value.udid, img: images[0], name: value.s_Company, price: String(value.i_Price)))
                        self.carCollectionView.reloadData()
                    })
                }
                self.carCollectionView.reloadData()
            }
        }
    }
}
