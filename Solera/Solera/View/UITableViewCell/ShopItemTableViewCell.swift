//
//  ShopItemTableViewCell.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import UIKit

// MARK: ShopItemTableViewCell class
class ShopItemTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ShopItemTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var item: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
    }
    
    func addToBasket(sender:UIButton!) {
        Persistence.shared.realm.addToBasket(item: item!)
        
        // Highlight cell to give visual feeback to the user
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        }) { (finished) in
            UIView.animate(withDuration: 0.1, animations: {
                self.backgroundColor = UIColor.white
            })
        }
    }
}

