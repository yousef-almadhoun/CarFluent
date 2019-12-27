//
//  ChooseYourRideViewController.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import FSPagerView
import FloatRatingView

class ChooseYourRideViewController: UIViewController {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
            
        }
    }
    
    var imageCar: [String] = []
    
    @IBOutlet weak var lblOwner: UILabel!
    
    @IBOutlet weak var rating: FloatRatingView!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    var data: ReservationCarData?
    
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
    
    @IBAction func btnOkey(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "OffersCarsViewController") as! OffersCarsViewController
        vc.data = data
        vc.image = imageCar
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ChooseYourRideViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 10.0
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
        self.pagerView.decelerationDistance = FSPagerView.automaticDistance
        self.rating.isUserInteractionEnabled = false
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        FirebaseManager.shared.getCars { (data) in
            for (_, value) in data.enumerated() {
                if value.udid == self.data?.idCar {
                    self.lblOwner.text = value.s_Company
                    self.lblType.text = value.s_Type
                    self.lblDescription.text = value.s_Description
                    if let price = self.data?.carPrice, let ratingCar = value.s_Rating {
                        self.lblPrice.text = "\(price)$"
                        self.rating.rating = Double(ratingCar) as? Double ?? 5.0
                    }
                }
            }
        }
    }
    
}

extension ChooseYourRideViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageCar.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: URL.init(string: self.imageCar[index]), placeholder: "imgSplash".image_)
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
}
