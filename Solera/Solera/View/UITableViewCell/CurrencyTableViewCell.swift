//
//  CurrencyTableViewCell.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import UIKit

// MARK: CurrencyTableViewCell class
class CurrencyTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CurrencyTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
