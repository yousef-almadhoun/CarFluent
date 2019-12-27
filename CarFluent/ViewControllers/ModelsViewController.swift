//
//  ModelsViewController.swift
//  CarFluent
//
//  Created by mac on 11/27/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import iOSDropDown

class ModelsViewController: UIViewController {

    @IBOutlet weak var modelsCollectionView: UICollectionView!
    
    @IBOutlet weak var versionCollectionView: UICollectionView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var dwTransmission: DropDown!
    
    @IBOutlet weak var dwFuel: DropDown!
    
    var modelsData: [String] = []
    
    var versionData: [String] = []
    
    var color: [String] = []
    
    var transmission: String?
    
    var fuel: String?
    
    var colorSelected: String?
    
    var selectedItem: Int?
    
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
        
        guard let transmission = self.transmission else {
            showAlertError(message: "Please Enter A Type Transmission")
            return
        }
        
        guard let fuel = self.fuel else {
            showAlertError(message: "Please Enter A Type Fuel")
            return
        }
        
        guard let selectedColor = self.colorSelected else {
            showAlertError(message: "Please Enter Select A Color")
            return
        }
        
        data?.transmission = transmission
        data?.fuel = fuel
        data?.color = selectedColor
        data?.fuelRatio = "\(Int(slider.value))"
        
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "GuidedlineAreservationViewController") as! GuidedlineAreservationViewController
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension ModelsViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        modelsCollectionView.register(UINib.init(nibName: "CarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCollectionViewCell")
        versionCollectionView.register(UINib.init(nibName: "CarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCollectionViewCell")
        colorCollectionView.register(UINib.init(nibName: "ColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
    }
    
    func localized() {
        
    }
    
    func setupData() {
        dwTransmission.optionArray = ["Manual", "Automatic"]
        dwFuel.optionArray = ["Gasoline", "Solar"]
        dwTransmission.didSelect { (select, id, index) in
            self.transmission = select
        }
        dwFuel.didSelect { (select, id, index) in
            self.fuel = select
        }
    }
    
    func fetchData() {
        
    }
    
}

extension ModelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == modelsCollectionView {
            return modelsData.count
        } else if collectionView == versionCollectionView {
            return versionData.count
        } else {
            return color.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == modelsCollectionView {
            let cell: CarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell",  for: indexPath) as! CarCollectionViewCell
            cell.hideAnimated()
            let obj = self.modelsData[indexPath.row]
            cell.object = obj
            cell.configureCell()
            return cell
        } else if collectionView == versionCollectionView {
            let cell: CarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell",  for: indexPath) as! CarCollectionViewCell
            cell.hideAnimated()
            let obj = self.versionData[indexPath.row]
            cell.object = obj
            cell.configureCell()
            return cell
        } else {
            let cell: ColorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell",  for: indexPath) as! ColorCollectionViewCell
            cell.indexPath = indexPath
            let obj = self.color[indexPath.row]
            cell.object = obj
            cell.configureCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorCollectionView {
            if selectedItem == nil || selectedItem != indexPath.row {
                self.selectedItem = indexPath.row
                self.colorSelected = color[selectedItem ?? 0]
            }
            colorCollectionView.reloadData()
        }
    }
}

extension ModelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colorCollectionView {
            let width: CGFloat = 45
            let height: CGFloat = 45
            return CGSize.init(width: width, height: height)
        } else {
            let width: CGFloat = 95
            let height: CGFloat = 95
            return CGSize.init(width: width, height: height)
        }
    }
}
