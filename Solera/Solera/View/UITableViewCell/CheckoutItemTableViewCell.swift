//
//  CheckoutItemTableViewCell.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import UIKit

// MARK: CheckOutItemTableViewCell class
class CheckOutItemTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CheckOutItemTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var item: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        removeButton.addTarget(self, action: #selector(removeFromBasket), for: .touchUpInside)
    }
    
    func removeFromBasket(sender:UIButton!) {
        Persistence.shared.realm.removeFromBasket(item: item!)
    }
    
}
