//
//  FilterViewController.swift
//  CarFluent
//
//  Created by mac on 11/25/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import TTRangeSlider
import iOSDropDown

class FilterViewController: UIViewController {

    @IBOutlet weak var tableViewSort: UITableView!
    
    @IBOutlet weak var lblMinPrice: UILabel!
    
    @IBOutlet weak var lblMaxPrice: UILabel!
    
    @IBOutlet weak var slider: TTRangeSlider!
    
    @IBOutlet weak var dwTaxiOffice: DropDown!
    
    let sortList: [sortBy] = [.heightRating, .heightCost, .lowCost, .mostFamouse]
    
    var selectedItem: Int?
    
    var seletedSort: String?
    
    var officer: String?
    
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
    
    @IBAction func btnFilter(_ sender: Any) {
        let minPrice = lblMinPrice.text?.dropLast()
        let maxPrice = lblMaxPrice.text?.dropLast()
        self.performSegue(withIdentifier: "unwindToFilterFor", sender: FilterData.init(sort: seletedSort ?? "aa", minPrice: String(minPrice ?? ""), maxPrice: String(maxPrice ?? ""), officer: officer ?? ""))
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToFilterFor" {
            if let vc = segue.destination as? HomeViewController {
                vc.filter = sender as? FilterData ?? FilterData.init(sort: "", minPrice: "", maxPrice: "", officer: "")
            }
        }
    }
    
}

extension FilterViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tableViewSort.register(UINib.init(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
        self.lblMinPrice.text = "\(Int(slider.selectedMinimum))$"
        self.lblMaxPrice.text = "\(Int(slider.selectedMaximum))$"
        self.dwTaxiOffice.insertText("city center")
        dwTaxiOffice.didSelect { (value, index, id)  in
            self.officer = value
        }
    }
    
    func localized() {
        
    }
    
    func setupData() {

    }
    
    func fetchData() {
        FirebaseManager.shared.getUsers { (data) in
            for (_, value) in data.enumerated() {
                if value.s_TypeUser == "dealer" {
                    self.dwTaxiOffice.optionArray.append(value.s_Name)
                }
            }
        }
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell",  for: indexPath) as! FilterTableViewCell
        cell.indexPath = indexPath
        let obj = self.sortList[indexPath.row].sort
        cell.object = obj
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedItem == nil || selectedItem != indexPath.row {
            self.selectedItem = indexPath.row
            self.seletedSort = self.sortList[indexPath.row].sort
        }
        tableViewSort.reloadData()
    }
    
}

extension FilterViewController: TTRangeSliderDelegate {
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        self.lblMinPrice.text = "\(Int(selectedMinimum)) $"
        self.lblMaxPrice.text = "\(Int(selectedMaximum)) $"
    }
}
