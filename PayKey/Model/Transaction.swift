//
//  Transaction.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    let sku: String
    let amount: String
    let currency: Currency
}
