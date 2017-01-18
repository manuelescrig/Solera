//
//  CurrencyViewController.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import Alamofire
import SwiftyJSON

// MARK: CurrencyViewController class
class CurrencyViewController: UITableViewController {
    
    static let currencyAPIKey = "71c64ff042421cf45dffee42d510c65f"
    
    var currencies = Persistence.shared.realm.currencies
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Currency"
        
        // Update Currencies Online
        Network.shared.updateCurrencies { (success) in
            if (success) {
                self.currencies = Persistence.shared.realm.currencies
                self.tableView.reloadData()
            }
        }
        
        // Add navigation bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(changeCurrency))
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellIdentifier, for: indexPath) as! CurrencyTableViewCell
        cell.titleLabel.text = currencies[indexPath.row].name
        cell.subtitleLabel?.text = String(format: "Rate: %.2f", currencies[indexPath.row].rate)
        if (currencies[indexPath.row].key ==  Settings.shared.getCurrency()) {
            cell.backgroundColor = UIColor.gray
        } else {
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Currencies"
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Settings.shared.setCurrency(currencies[indexPath.row].key)
    }
    
    
    // MARK: - UI Actions
    func changeCurrency() {
        self.dismiss(animated: true) {}
    }
    
}
