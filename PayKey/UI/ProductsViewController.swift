//
//  ProductsViewController.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var productsTableView: UITableView!
    var products: [Product]!
    weak var delegate: ProductsFlowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //move parsing here
        productsTableView.dataSource = self
        productsTableView.delegate = self
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.className, for: indexPath) as? ProductTableViewCell else {
            return cell
        }
        
        productCell.setValues(from: products[indexPath.row])
        cell = productCell
        
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.didChooseProduct(products[indexPath.row].sku, sender: self)
    }
}
