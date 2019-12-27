//
//  SearchHistoryTableViewCell.swift
//  CarFluent
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import MagicalRecord

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSearch: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var object: SearchHistory?
    
    func configureCell() {
        if let obj = self.object {
            self.lblSearch.text = object?.search
        }
    }
    
    @IBAction func btnRemove(_ sender: Any) {
        if let parent = self.parentViewController as? SearchViewController {
            if let index = parent.object.firstIndex(where: { $0.id == self.object?.id}) {
                if let data = TSearch.mr_findFirst(with: NSPredicate.init(format: "id = %@", "\(index)")) {
                    data.mr_deleteEntity()
                    NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
                }
                parent.object.remove(at: index)
                parent.tableView.reloadData()
            }
        }
    }
    
}
