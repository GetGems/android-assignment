//
//  Product.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

struct Product {
    let sku: String
    let transactionsCount: Int
    
    init(sku: String, transactionsCount: Int) {
        self.sku = sku
        self.transactionsCount = transactionsCount
    }
}
