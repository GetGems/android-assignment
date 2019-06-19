//
//  ProductsFlowManager.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation
import UIKit

protocol ProductsFlowDelegate: class {
    func didChooseProduct(_ sku: String, sender: UIViewController)
}

class ProductsFlowManager: ProductsFlowDelegate {
    let dataProvider: LocalJsonDataProvider
    let dataProcessor: DataProcessor
    var transactionsByProduct: [String: [Transaction]]!
    var toGBPrates: [ExchangeRate]!
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(dataProvider: LocalJsonDataProvider = LocalJsonDataProvider(), dataProcessor: DataProcessor = DataProcessor()) {
        self.dataProvider = dataProvider
        self.dataProcessor = dataProcessor
        initData()
    }
    
    private func initData() {
        guard let transactionsData = dataProvider.getTransactions() else {
            print("FATAL ERROR: Didn't get transactions")
            return
        }
        
        transactionsByProduct = dataProcessor.generateProducts(from: transactionsData)

        guard let rates = dataProvider.getRates() else {
            print("FATAL ERROR: Didn't get rates")
            return
        }
        
        toGBPrates = dataProcessor.createRates(rates)
    }
    
    func getStartingVC() -> UIViewController {
        guard let productsVC = storyboard.instantiateViewController(withIdentifier: ProductsViewController.className) as? ProductsViewController else {
            print("ERROR: Couldn't instantiate ViewController: \(ProductsViewController.className)")
            return UIViewController()
        }

        productsVC.products = dataProcessor.createProductsDataSource(productsAndTransactions: transactionsByProduct)
        productsVC.delegate = self
        
        return productsVC
    }
    
    func didChooseProduct(_ sku: String, sender: UIViewController) {
        if let productTransactions = transactionsByProduct[sku] {
            let dataSource = dataProcessor.generateGroupedTransactions(productTransactions)
            showProductVC(dataSource, sender: sender)
        } else {
            print("ERROR: Coudldn't find such sku: \(sku)")
        }
    }

    private func showProductVC(_ dataSource: [TransactionsByCurrency], sender: UIViewController) {
        guard let transactionsVC = storyboard.instantiateViewController(withIdentifier: ProductTransactionsViewController.className) as? ProductTransactionsViewController else {
            print("ERROR: Couldn't instantiate ViewController: \(ProductTransactionsViewController.className)")
            return
        }

        transactionsVC.dataSource = dataSource
        sender.present(transactionsVC, animated: true)
    }
}
