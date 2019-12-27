//
//  OffersCarsViewController.swift
//  CarFluent
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class OffersCarsViewController: UIViewController {

    @IBOutlet weak var imgCompany: UIImageView!
    
    @IBOutlet weak var lblModels: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imgCar: UIImageView!
    
    var color: [String] = []
    
    var data: ReservationCarData?
    
    var image: [String] = []
    
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
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ModelsViewController") as! ModelsViewController
        vc.data = data
        vc.modelsData = image
        vc.versionData = image
        vc.color = color
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OffersCarsViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionView.register(UINib.init(nibName: "ColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
        imgCar?.kf.indicatorType = .activity
        imgCar?.kf.setImage(with: URL.init(string: self.image[0] ?? ""), placeholder: "imgSplash".image_)
        imgCar?.contentMode = .scaleToFill
        imgCar?.clipsToBounds = true
        self.showAnimated()
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        FirebaseManager.shared.getColor(udid: data?.idCar ?? "") { (data) in
            self.color = data
            self.collectionView.reloadData()
        }
        
        FirebaseManager.shared.getCompanyData { (data) in
            for (_, value) in data.enumerated() {
                if self.data?.company?.lowercased() == value.s_Name.lowercased() {
                    self.hideAnimated()
                    self.imgCompany.kf.indicatorType = .activity
                    self.imgCompany.kf.setImage(with: URL.init(string: value.s_Image), placeholder: "imgSplash".image_)
                    self.imgCompany.contentMode = .scaleAspectFit
                    self.imgCompany.clipsToBounds = true
                    self.lblModels.text = self.data?.type
                }
            }
        }
    }
    
}

extension OffersCarsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ColorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell",  for: indexPath) as! ColorCollectionViewCell
        cell.indexPath = indexPath
        let obj = self.color[indexPath.row]
        cell.object = obj
        cell.configureCell()
        return cell
    }
    
}

extension OffersCarsViewController {
    
    func showAnimated() {
        self.imgCompany.showAnimatedGradientSkeleton()
        self.lblModels.showAnimatedGradientSkeleton()
    }
    
    func hideAnimated() {
        self.imgCompany.hideSkeleton()
        self.lblModels.hideSkeleton()
    }
    
}

extension OffersCarsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 45
        let height: CGFloat = 45
        return CGSize.init(width: width, height: height)
    }
}
