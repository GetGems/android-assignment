//
//  DataProcessor.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

class DataProcessor {
    
    func generateProducts(from transactions: Data) -> [String: [Transaction]]? {
        var result = [String: [Transaction]]()
        
        guard let transactions = try? JSONDecoder().decode([Transaction].self, from: transactions) else {
            print("Error: Couldn't decode data into [Transaction]")
            return nil
        }
        
        for transaction in transactions {
            if let _ = result[transaction.sku] {
                result[transaction.sku]!.append(transaction)
            } else {
                result[transaction.sku] = [transaction]
            }
        }
        
        return result
    }
    
    func createProductsDataSource(productsAndTransactions: [String: [Transaction]]) -> [Product]{
        var result = [Product]()
        
        for key in productsAndTransactions.keys {
            if let transactionsArray = productsAndTransactions[key] {
                let product = Product(sku: key, transactionsCount: transactionsArray.count)
                result.append(product)
            } else {
                print("WARNING: no transactions array for key: \(key)")
            }
        }
        
        return result
    }
    
    func generateGroupedTransactions(_ transactions: [Transaction]) -> [TransactionsByCurrency] {
        let transactionsByCurrencyDict = Dictionary(grouping: transactions, by: { $0.currency})
        var transactionsByCurrencyArray = [TransactionsByCurrency]()
        
        for currency in transactionsByCurrencyDict.keys {
            var item = TransactionsByCurrency(transactions: [Double](), currency: currency)
            for transaction in transactionsByCurrencyDict[currency]! {
                if let amountAsDouble = Double(transaction.amount) {
                    item.transactions.append(amountAsDouble)
                } else {
                    print("WARNING: Couldn't convert \(transaction.amount) to double - omitting this transaction.")
                }
            }
            
            transactionsByCurrencyArray.append(item)
        }
        
        return transactionsByCurrencyArray
    }
    
    func convertToGBP(currencyTransactions: [TransactionsByCurrency], rates: [ExchangeRate]) {
        //TODO
    }
    
    func createRates(_ ratesData: Data) -> [ExchangeRate]? {
        var result = [ExchangeRate]()
        
        guard let rates = try? JSONDecoder().decode([ExchangeRate].self, from: ratesData) else {
            print("Error: Couldn't decode data into [ExchangeRate]")
            return nil
        }
        
        for rate in rates {
            result.append(rate)
        }
        
        return result
    }
}
