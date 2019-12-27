//
//  StartAreservationViewController.swift
//  CarFluent
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import FSPagerView

class StartAreservationViewController: UIViewController {
    
    @IBOutlet weak var iconFavorite: UIImageView!
    
    @IBOutlet weak var imgCar: UIImageView!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblPrice2: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageCar.count
            pageControl.setFillColor(UIColor.hexColor(hex: "#D2D2D2"), for: .normal)
            pageControl.setFillColor(UIColor.hexColor(hex: "#FFB02B"), for: .selected)
        }
    }
    
    enum favorite {
        case favorite
        case notFavorite
    }
    
    var favoriteCar: favorite = .notFavorite {
        didSet {
            favoriteFunc()
        }
    }
    
    var imageCar: [String] = [""]
    
    var data: ReservationCarData?
    
    var favoriteId: String?
    
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
    
    @IBAction func btnFavorite(_ sender: Any) {
        if favoriteCar == .favorite {
            favoriteCar = .notFavorite
            FirebaseManager.shared.deleteFavorite(udid: favoriteId ?? "")
        } else {
            favoriteCar = .favorite
            FirebaseManager.shared.addFavorite(udidUser: FirebaseManager.shared.getUserId(), udidCar: data?.idCar ?? "")
        }
    }
    
    @IBAction func btnOkey(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ChooseYourRideViewController") as! ChooseYourRideViewController
        data?.idPerson = FirebaseManager.shared.getUserId()
        vc.data = data
        vc.imageCar = self.imageCar
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension StartAreservationViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 10.0
        self.pagerView.decelerationDistance = FSPagerView.automaticDistance
        self.showAnimated()
    }
    
    func localized() {
        
    }
    
    func setupData() {
    
    }
    
    func fetchData() {
        FirebaseManager.shared.getCars { (data) in
            self.hideAnimated()
            for (_, value) in data.enumerated() {
                if value.udid == self.data?.idCar {
                    self.data?.owner = value.s_CarOwner
                    self.lblType.text = value.s_Company
                    self.lblTitle.text = value.s_Type
                    self.lblDescription.text = value.s_Description
                    self.data?.company = value.s_Company
                    self.data?.type = value.s_Type
                    if let price = self.data?.carPrice {
                        self.lblPrice.text = "\(price)$ perDay"
                        self.lblPrice2.text = "\(price)$"
                    }
                    FirebaseManager.shared.addWatch(udid: self.data?.idCar ?? "")
                    FirebaseManager.shared.getFavorite(completion: { (favorite) in
                        for (_, value) in favorite.enumerated() {
                            if value.s_IdUser == FirebaseManager.shared.getUserId() && value.s_IdCar == self.data?.idCar {
                                self.favoriteCar = .favorite
                                self.favoriteId = value.udid
                                break
                            }
                        }
                    })
                    break
                }
            }
            
            FirebaseManager.shared.getImage(udid: self.data?.idCar ?? "", completion: { (data) in
                self.imageCar = data
                self.pageControl.numberOfPages = data.count
                self.pagerView.reloadData()
                self.imgCar.kf.setImage(with: URL.init(string: self.imageCar[0]), placeholder: "imgSplash".image_)
                self.imgCar.contentMode = .scaleToFill
                self.imgCar.clipsToBounds = true
            })
        }
    }
    
}

extension StartAreservationViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageCar.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: URL.init(string: self.imageCar[index]), placeholder: "imgSplash".image_)
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
        cell.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
}

extension StartAreservationViewController {
    
    func showAnimated() {
        self.lblType.showAnimatedGradientSkeleton()
        self.lblTitle.showAnimatedGradientSkeleton()
        self.lblDescription.showAnimatedGradientSkeleton()
        self.lblPrice.showAnimatedGradientSkeleton()
        self.lblPrice2.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.lblType.hideSkeleton()
        self.lblTitle.hideSkeleton()
        self.lblDescription.hideSkeleton()
        self.lblPrice.hideSkeleton()
        self.lblPrice2.hideSkeleton()
    }
    
    func favoriteFunc() {
        switch self.favoriteCar {
        case .favorite:
            iconFavorite.image = "icFavorite".image_
            break
        case .notFavorite:
            iconFavorite.image = "icFavoriteNotSelected".image_
            break
        }
    }
    
}
