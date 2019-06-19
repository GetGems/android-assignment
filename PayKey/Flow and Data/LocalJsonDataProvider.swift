//
//  DataProvider.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

class LocalJsonDataProvider: DataProviderProtocol {
    let transactionsFileName: String
    let ratesFileName: String

    init(transactionsFileName: String = "transactions1", ratesFileName: String = "rates1") {
        self.transactionsFileName = transactionsFileName
        self.ratesFileName = ratesFileName
    }
    
    func getTransactions() -> Data? {
        return getFile(transactionsFileName)
    }
    
    func getRates() -> Data? {
        return getFile(ratesFileName)
    }
    
    private func getFile(_ fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                
                return data
            } catch {
                print("ERROR: Couldn't get data from file: \(fileName)")
            }
        } else {
            print("ERROR: can't find file: \(fileName)")
        }
        
        return nil
    }
}
