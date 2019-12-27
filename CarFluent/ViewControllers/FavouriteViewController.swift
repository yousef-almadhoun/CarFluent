//
//  FavouriteViewController.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyFavourite: UIView!
    
    var objects: [Favourite]?
    
    var num: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FavouriteViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionView.register(UINib.init(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCollectionViewCell")
        let refControl = UIRefreshControl()
        refControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        collectionView.refreshControl = refControl
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    @objc func fetchData() {
        FirebaseManager.shared.getFavorite { (data) in
            self.objects?.removeAll()
            self.collectionView.refreshControl?.endRefreshing()
            if self.objects == nil {
                self.objects = []
            }
            for (_, value) in data.enumerated() {
                if value.s_IdUser == FirebaseManager.shared.getUserId() {
                    FirebaseManager.shared.getCars(completion: { (cars) in
                        self.num = 0
                        for (_, val) in cars.enumerated() {
                            if value.s_IdCar == val.udid {
                                let obj = Favourite.init(idFavourite: value.udid, idCar: val.udid, priceCar: String(val.i_Price), imgCar: "", title: val.s_Title, description: val.s_Description, rating: val.s_Rating)
                                FirebaseManager.shared.getImage(udid: val.udid, completion: { (image) in
                                    obj.imgCar = image[0]
                                    self.objects?.append(obj)
                                    self.collectionView.reloadData()
                                })
                                
                            }
                        }
                    })
                }
            }
            self.collectionView.reloadData()
        }
    }
    
}

extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if objects?.count == 0 {
            self.emptyFavourite.isHidden = false
        } else {
            self.emptyFavourite.isHidden = true
        }
        return objects?.count ?? num ?? 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavouriteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell",  for: indexPath) as! FavouriteCollectionViewCell
        collectionView.allowsSelection = false
        if let objects = objects {
            self.emptyFavourite.isHidden = true
            cell.hideAnimated()
            let obj = objects[indexPath.row]
            cell.object = obj
            cell.configureCell()
            collectionView.allowsSelection = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "StartAreservationViewController") as! StartAreservationViewController
        vc.data = ReservationCarData.init(idPerson: "", owner: "", company: "", type: "", location: "", timeTo: "", timeFrom: "", dateTo: "", dateFrom: "", idCar: "", carPrice: "", transmission: "", fuel: "", color: "", fuelRatio: "", paymentMethod: "")
        vc.data?.idCar = objects?[indexPath.row].idCar
        vc.data?.carPrice = objects?[indexPath.row].priceCar
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.size.width - 40) / 2
        let height: CGFloat = 250.0
        return CGSize.init(width: width, height: height)
    }
}
