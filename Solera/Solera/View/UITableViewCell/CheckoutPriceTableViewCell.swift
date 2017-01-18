//
//  CheckoutPriceTableViewCell.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import UIKit

// MARK: CheckOutPriceTableViewCell class
class CheckOutPriceTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CheckOutPriceTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
