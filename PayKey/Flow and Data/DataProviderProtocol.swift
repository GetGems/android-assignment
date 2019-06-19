//
//  DataProviderProtocol.swift
//  PayKey
//
//  Created by yulia felberg on 19/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

protocol DataProviderProtocol: class {
    func getTransactions() -> Data?
    func getRates() -> Data?
}
