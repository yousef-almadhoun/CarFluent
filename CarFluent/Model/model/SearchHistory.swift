//
//  SearchHistory.swift
//  CarFluent
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation

class SearchHistory {
    
    var id: Int?
    
    var search: String?
    
    init (id: Int, search: String) {
        self.id = id
        self.search = search
    }
    
}
