//
//  HomeViewController.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewCustomized: UICollectionView!
    
    @IBOutlet weak var collectionViewCarPager1: UICollectionView!
    
    @IBOutlet weak var collectionViewCarPager2: UICollectionView!
    
    @IBOutlet weak var collectionViewOffers1: UICollectionView!
    
    @IBOutlet weak var collectionViewOffers2: UICollectionView!
    
    @IBOutlet weak var tableViewModels: UITableView!
    
    @IBOutlet weak var lblOffer1NewPrice: UILabel!
    
    @IBOutlet weak var lblOffer1OldPreice: UILabel!
    
    @IBOutlet weak var lblOffer2NewPrice: UILabel!
    
    @IBOutlet weak var lblOffer2OldPrice: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var constraintTableViewHeight: NSLayoutConstraint!
    
    var dataCar: [TCar] = []
    
    var carCustomizeData: [CarCustomize]?
    
    var carPager1Data: [CarPager]?
    
    var carPager2Data: [CarPager]?
    
    var carOffers1Data: [CarPager]?
    
    var carOffers2Data: [CarPager]?
    
    var carModelsData: [ModelsCar]?
    
    var filterObjects: [Search]?
    
    var filter: FilterData?
    
    var search: String?
    
    var sort: String?
    
    var minPrice: String?
    
    var maxPrice: String?
    
    var officer: String?
    
    var isSearch: Bool = false {
        didSet {
            search(isSearch: isSearch)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.layoutSubviews()
        scrollView.layoutIfNeeded()
        self.constraintTableViewHeight.constant = self.tableViewModels.contentSize.height
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "FilterViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SearchViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func unwindToFilter(for unwindSegue: UIStoryboardSegue) {
        self.filterFunc(search: search ?? "", minPrice: filter?.minPrice ?? "0", maxPrice: filter?.maxPrice ?? "0", officer: filter?.officer ?? "")
    }
    
}

extension HomeViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionViewCustomized.register(UINib.init(nibName: "CarCustomizedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCustomizedCollectionViewCell")
        collectionViewCarPager1.register(UINib.init(nibName: "CarPagerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarPagerCollectionViewCell")
        collectionViewCarPager2.register(UINib.init(nibName: "CarPagerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarPagerCollectionViewCell")
        collectionViewOffers1.register(UINib.init(nibName: "CarPagerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarPagerCollectionViewCell")
        collectionViewOffers2.register(UINib.init(nibName: "CarPagerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarPagerCollectionViewCell")
        tableViewModels.register(UINib.init(nibName: "ModelsTableViewCell", bundle: nil), forCellReuseIdentifier: "ModelsTableViewCell")
        tableViewModels.register(UINib.init(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        lblOffer1NewPrice.text = "50"
        lblOffer1OldPreice.text = "70"
        lblOffer2NewPrice.text = "35"
        lblOffer2OldPrice.text = "50"
        let refControl = UIRefreshControl()
        refControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        scrollView.refreshControl = refControl
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    @objc func fetchData() {
        FirebaseManager.shared.getCars { (cars) in
            FirebaseManager.shared.getOffers { (offers) in
                self.carCustomizeData?.removeAll()
                self.carPager1Data?.removeAll()
                self.carPager2Data?.removeAll()
                self.carOffers1Data?.removeAll()
                self.carOffers2Data?.removeAll()
                self.carModelsData?.removeAll()
                self.scrollView.refreshControl?.endRefreshing()
                for (_, val) in cars.enumerated() {
                    /*
                     *  get Models car
                     */
                    if let price = val.i_Price {
                        if self.carModelsData == nil {
                            self.carModelsData = []
                        }
                        self.carModelsData?.append(ModelsCar.init(idCar: val.udid, imgCar: val.ar_Image[0], name: val.s_Company, price: "\(price)"))
                    }
                    /*
                     *  get offers car
                     */
                    for(_, value) in offers.enumerated() {
                        if value.s_id_car == val.udid {
                            if let oldPrice = val.i_Price, let newPrice = value.i_offer_price {
                                if self.carCustomizeData == nil {
                                    self.carCustomizeData = []
                                }
                                self.carCustomizeData?.append(CarCustomize.init(idCar: val.udid, imgCar: val.ar_Image[0], name: val.s_Title, oldPrice: "\(oldPrice)", newPrice: "\(newPrice)"))
                                if oldPrice == Int(self.lblOffer1OldPreice.text ?? "0") && newPrice == Int(self.lblOffer1NewPrice.text ?? "0") {
                                    if self.carOffers1Data == nil {
                                        self.carOffers1Data = []
                                    }
                                    self.carOffers1Data?.append(CarPager.init(idCar: value.s_id_car, imgCar: val.ar_Image[0], name: val.s_Type, price: String(value.i_offer_price)))
                                } else if oldPrice == Int(self.lblOffer2OldPrice.text ?? "0") && newPrice == Int(self.lblOffer2NewPrice.text ?? "0") {
                                    if self.carOffers2Data == nil {
                                        self.carOffers2Data = []
                                    }
                                    self.carOffers2Data?.append(CarPager.init(idCar: value.s_id_car, imgCar: val.ar_Image[0], name: val.s_Type, price: String(value.i_offer_price)))
                                }
                            }
                        }
                    }
                }
                self.tableViewModels.reloadData()
                self.collectionViewCustomized.reloadData()
                self.collectionViewOffers1.reloadData()
                self.collectionViewOffers2.reloadData()
                self.viewDidLayoutSubviews()
            }
            /*
             *  get car collection car
             */
            FirebaseManager.shared.getHomeCollection(completion: { (collectionCar) in
                for (_, val) in cars.enumerated() {
                    for(_, value) in collectionCar.enumerated() {
                        if value.s_id_car == val.udid {
                            if value.s_Priority == "1" {
                                if self.carPager1Data == nil {
                                    self.carPager1Data = []
                                }
                                self.carPager1Data?.append(CarPager.init(idCar: value.s_id_car, imgCar: val.ar_Image[0], name: "Collection", price: String(val.i_Price)))
                            } else if value.s_Priority == "2" {
                                if self.carPager2Data == nil {
                                    self.carPager2Data = []
                                }
                                self.carPager2Data?.append(CarPager.init(idCar: value.s_id_car, imgCar: val.ar_Image[0], name: "Collection", price: String(val.i_Price)))
                            }
                        }
                    }
                }
                self.collectionViewCarPager1.reloadData()
                self.collectionViewCarPager2.reloadData()
            })
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewCustomized {
            return carCustomizeData?.count ?? 3
        } else if collectionView == collectionViewCarPager1 {
            return carPager1Data?.count ?? 3
        } else if collectionView == collectionViewCarPager2 {
            return carPager2Data?.count ?? 3
        } else if collectionView == collectionViewOffers1 {
            return carOffers1Data?.count ?? 3
        } else {
            return carOffers2Data?.count ?? 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewCustomized {
            collectionView.allowsSelection = false
            let cell: CarCustomizedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCustomizedCollectionViewCell",  for: indexPath) as! CarCustomizedCollectionViewCell
            if let carCustomizeData = carCustomizeData {
                cell.hideAnimated()
                let obj = carCustomizeData[indexPath.row]
                cell.object = obj
                cell.configureCell()
                collectionView.allowsSelection = true
            }
            return cell
        } else if collectionView == collectionViewCarPager1 {
            let cell: CarPagerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarPagerCollectionViewCell",  for: indexPath) as! CarPagerCollectionViewCell
            if let data = carPager1Data {
                cell.hideAnimated()
                let obj = data[indexPath.row]
                cell.object = obj
                cell.configureCell()
            }
            return cell
        } else if collectionView == collectionViewCarPager2 {
            let cell: CarPagerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarPagerCollectionViewCell",  for: indexPath) as! CarPagerCollectionViewCell
            if let data = carPager2Data {
                cell.hideAnimated()
                let obj = data[indexPath.row]
                cell.object = obj
                cell.configureCell()
            }
            return cell
        } else if collectionView == collectionViewOffers1 {
            let cell: CarPagerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarPagerCollectionViewCell",  for: indexPath) as! CarPagerCollectionViewCell
            if let data = carOffers1Data {
                cell.hideAnimated()
                let obj = data[indexPath.row]
                cell.object = obj
                cell.configureCell()
            }
            return cell
        } else {
            let cell: CarPagerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarPagerCollectionViewCell",  for: indexPath) as! CarPagerCollectionViewCell
            if let data = carOffers2Data {
                cell.hideAnimated()
                let obj = data[indexPath.row]
                cell.object = obj
                cell.configureCell()
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCustomized {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "StartAreservationViewController") as! StartAreservationViewController
            vc.data = ReservationCarData.init(idPerson: "", owner: "", company: "", type: "", location: "", timeTo: "", timeFrom: "", dateTo: "", dateFrom: "", idCar: "", carPrice: "", transmission: "", fuel: "", color: "", fuelRatio: "", paymentMethod: "")
            vc.data?.idCar = carCustomizeData?[indexPath.row].idCar
            vc.data?.carPrice = carCustomizeData?[indexPath.row].newPrice
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewCustomized {
            let width:  CGFloat = 165
            let height: CGFloat = 210
            return CGSize.init(width: width, height: height)
        } else if collectionView == collectionViewCarPager1 ||  collectionView == collectionViewCarPager2 {
            let width: CGFloat = 323
            let height: CGFloat = 317
            return CGSize.init(width: width, height: height)
        } else {
            let width: CGFloat = 166
            let height: CGFloat = 168
            return CGSize.init(width: width, height: height)
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModelsData?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearch {
            let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell",  for: indexPath) as! SearchTableViewCell
            if let data = filterObjects {
                //cell.hideAnimated()
                let obj = data[indexPath.row]
                cell.object = obj
                //cell.configureCell()
            }
            return cell
        } else {
            let cell: ModelsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ModelsTableViewCell",  for: indexPath) as! ModelsTableViewCell
            if let data = carModelsData {
                cell.hideAnimated()
                let obj = data[indexPath.row]
                cell.object = obj
                cell.configureCell()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 397
    }
    
}

extension HomeViewController {
    
    func filterFunc(search: String, minPrice: String, maxPrice: String, officer: String) {
        FirebaseManager.shared.getCars { (data) in
            self.filterObjects?.removeAll()
            for (_, value) in data.enumerated() {
                if (value.s_Company.lowercased().contains(search.lowercased()) || search == "") {
                    if self.filterObjects == nil {
                        self.filterObjects = []
                    }
                    self.filterObjects?.append(Search.init(id: value.udid, image: "", owner: value.s_CarOwner, company: value.s_Company, type: value.s_Type, price: String(value.i_Price), watch: String(value.i_Watch), rating: value.s_Rating))
                }
            }
            self.tableViewModels.reloadData()
        }
    }
    
    func search(isSearch: Bool) {
        if isSearch {
            collectionViewCustomized.isHidden = true
            collectionViewCarPager1.isHidden = true
            collectionViewCarPager2.isHidden = true
            collectionViewOffers1.isHidden = true
            collectionViewOffers2.isHidden = true
        } else {
            collectionViewCustomized.isHidden = false
            collectionViewCarPager1.isHidden = false
            collectionViewCarPager2.isHidden = false
            collectionViewOffers1.isHidden = false
            collectionViewOffers2.isHidden = false
        }
    }
    
}
