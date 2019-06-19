//
//  ProductTransactionsViewController.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit

class ProductTransactionsViewController: UIViewController {

    @IBOutlet weak var transactionsTableView: UITableView!
    var dataSource: [TransactionsByCurrency]!
    private let transactionCellReuseIdentifier = "TransactionCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionsTableView.dataSource = self
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ProductTransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].currency.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: transactionCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = "\(dataSource[indexPath.section].transactions[indexPath.row])"           
        
        return cell
    }
}

