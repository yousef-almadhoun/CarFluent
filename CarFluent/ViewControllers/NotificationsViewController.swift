//
//  NotificationsViewController.swift
//  CarFluent
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation
import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noNotifications: UIView!
    
    var data: [Notifications]?
    
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

extension NotificationsViewController {
    
    func setupView() {
        tableView.register(UINib.init(nibName: "NotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationsTableViewCell")
        let refControl = UIRefreshControl()
        refControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refControl
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    @objc func fetchData() {
        FirebaseManager.shared.getNotifications { (data) in
            self.data?.removeAll()
            self.tableView.refreshControl?.endRefreshing()
            if data.count == 0 {
                self.noNotifications.isHidden = false
            }
            FirebaseManager.shared.getUsers(completion: { (users) in
                self.num = 0
                if self.data == nil {
                    self.data = []
                }
                for (_, uVal) in users.enumerated() {
                    for (_, value) in data.enumerated() {
                        if value.s_from == uVal.udid {
                            let obj: Notifications = Notifications.init(idNotifications: "", idReservation: "", img: "", name: "", notification: "", date: "")
                            obj.idNotifications = value.udid
                            obj.idReservation = value.s_IdReservation
                            obj.img = uVal.s_Image
                            obj.name = uVal.s_Name
                            obj.notification = value.s_message
                            obj.date = value.s_date.toDate(customFormat: "hh:mm a").toString(customFormat: "hh:mm a")
                            self.data?.append(obj)
                        }
                    }
                }
                self.tableView.reloadData()
            })
        }
    }
    
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data?.count == 0 {
            self.noNotifications.isHidden = false
        } else {
            self.noNotifications.isHidden = true
        }
        return data?.count ?? num ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as! NotificationsTableViewCell
        tableView.allowsSelection = false
        if let data = data {
            cell.hideAnimated()
            self.noNotifications.isHidden = true
            let obj = data[indexPath.row]
            cell.object = obj
            cell.configureCell()
            tableView.allowsSelection = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if data?[indexPath.row].notification?.lowercased() == "our reprsentative" {
            FirebaseManager.shared.getReservation { (data) in
                for (_, value) in data.enumerated() {
                    if value.udid == self.data?[indexPath.row].idReservation {
                        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "YourRecepitViewController") as! YourRecepitViewController
                        vc.idReservation = self.data?[indexPath.row].idReservation
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction.init(style: .destructive, title: "Delete") { (action, index) in
            FirebaseManager.shared.deleteNotifications(udid: self.data?[indexPath.row].idNotifications ?? "")
            self.data?.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return [delete]
    }
    
}
