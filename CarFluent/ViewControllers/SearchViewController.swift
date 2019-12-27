//
//  SearchViewController.swift
//  CarFluent
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import Foundation
import MagicalRecord

class SearchViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var object: [SearchHistory] = []
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToSearchFor" {
            if let vc = segue.destination as? HomeViewController {
                vc.search = sender as? String
            }
        }
    }

    
}

extension SearchViewController {
    
    func setupView() {
        tableView.register(UINib.init(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
        object.removeAll()
        if let count = TSearch.mr_findAll()?.count {
            for i in 0...count {
                if let data = TSearch.mr_findFirst(with: NSPredicate.init(format: "id = %@", "\(i)")) {
                    object.append(SearchHistory.init(id: Int(data.id), search: data.search ?? ""))
                }
            }
        }
        tableView.reloadData()
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        }
        self.performSegue(withIdentifier: "unwindToSearchFor", sender: txtSearch.text)
        let search = TSearch.mr_createEntity()
        search?.id = Int32(TSearch.mr_findAll()?.count ?? 0)
        search?.search = txtSearch.text
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        self.navigationController?.popViewController(animated: true)
        return true
    }
    
}

extension SearchViewController: UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell", for: indexPath) as! SearchHistoryTableViewCell
        cell.object = object[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "unwindToSearchFor", sender: object[indexPath.row].search)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
