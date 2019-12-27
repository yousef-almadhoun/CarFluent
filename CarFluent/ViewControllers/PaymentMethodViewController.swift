//
//  PaymentMethodViewController.swift
//  CarFluent
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit

class PaymentMethodViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let paymentMethodData: [paymentMethod] = [.paypal, .crediteCard, .masterCard, .visaCard, .cash]
    
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
    
}

extension PaymentMethodViewController {
    
    func setupView() {
        tableView.register(UINib.init(nibName: "PaymentMethodTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentMethodTableViewCell")
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}

extension PaymentMethodViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethodData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaymentMethodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell",  for: indexPath) as! PaymentMethodTableViewCell
        let obj = self.paymentMethodData[indexPath.row]
        cell.object = obj
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            showAlertPopUp(title: "Reserve A Car", message: "Your Order Has Been Successfully Sent", action1: {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
                self.data?.paymentMethod = "cash"
                FirebaseManager.shared.reservationCarData(idPerson: self.data?.idPerson ?? "", owner: self.data?.owner ?? "", location: self.data?.location ?? "", timeTo: self.data?.timeTo ?? "", timeFrom: self.data?.timeFrom ?? "", dateTo: self.data?.dateTo ?? "", dateFrom: self.data?.dateFrom ?? "", idCar: self.data?.idCar ?? "", carPrice: self.data?.carPrice ?? "", transmission: self.data?.transmission ?? "", fuel: self.data?.fuel ?? "", color: self.data?.color ?? "", fuelRatio: self.data?.fuelRatio ?? "", paymentMethod: self.data?.paymentMethod ?? "")
                self.navigationController?.setViewControllers([vc], animated: true)
            }) {

            }
        } else {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
            self.data?.paymentMethod = self.paymentMethodData[indexPath.row].paymentTitle
            self.data?.paymentMethod = "noCash"
            vc.data = self.data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
}
