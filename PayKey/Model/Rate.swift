//
//  Rate.swift
//  PayKey
//
//  Created by yulia felberg on 19/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

struct ExchangeRate: Decodable {
    let from: Currency
    let rate: String
    let to: Currency
}

