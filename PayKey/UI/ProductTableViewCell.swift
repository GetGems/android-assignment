//
//  ProductTableViewCell.swift
//  PayKey
//
//  Created by yulia felberg on 18/06/2019.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var transactionsCountLabel: UILabel!

    func setValues(from product: Product) {
        skuLabel.text = product.sku
        transactionsCountLabel.text = "\(product.transactionsCount)"
    }
}
