//
//  ShopViewController.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import RealmSwift

// MARK: ShowViewController class
class ShopViewController: UITableViewController {
    
    let items = Persistence.shared.realm.items
    var notificationToken: NotificationToken?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shop"
        
        // Detect first lunch in order to add data to the model
        if Settings.shared.hasLaunched() == false  {
            
            // Add initial data to the model
            Persistence.shared.realm.addItem(name: "Bag of Peas",    price: 0.95)
            Persistence.shared.realm.addItem(name: "Dozen Eggs",     price: 2.10)
            Persistence.shared.realm.addItem(name: "Bottle of Milk", price: 1.30)
            Persistence.shared.realm.addItem(name: "Can of Beans",   price: 0.73)
            Persistence.shared.realm.createBasket()
            Persistence.shared.realm.addCurrency(key:"USDUSD", name: "USD")
            Persistence.shared.realm.addCurrency(key:"USDAUD", name: "AUD")
            Persistence.shared.realm.addCurrency(key:"USDCAD", name: "CAD")
            Persistence.shared.realm.addCurrency(key:"USDGBP", name: "GBP")
            Persistence.shared.realm.addCurrency(key:"USDEUR", name: "EUR")
            Settings.shared.setCurrency("USDUSD")
            Settings.shared.setLaunched()
        }
        
        // Add navigation bar button item
        if (Persistence.shared.realm.basket.items.count > 0) {
            let checkout = String(format: "CheckOut (%d)", Persistence.shared.realm.basket.items.count)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: checkout, style: .plain, target: self, action: #selector(checkOut))
            
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CheckOut", style: .plain, target: self, action: #selector(checkOut))
        }
        
        // Update navigation bar button info
        notificationToken = Persistence.shared.realm.addNotificationBlock { notification, realm in
            if (Persistence.shared.realm.basket.items.count > 0) {
                self.navigationItem.rightBarButtonItem?.title = String(format: "CheckOut (%d)", Persistence.shared.realm.basket.items.count)
            } else {
                self.navigationItem.rightBarButtonItem?.title = "CheckOut"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    deinit {
        notificationToken?.stop()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopItemTableViewCell.cellIdentifier, for: indexPath) as! ShopItemTableViewCell
        cell.item = items[indexPath.row]
        cell.titleLabel?.text = items[indexPath.row].name
        cell.subtitleLabel?.text = String(format: "%.2f  %@", items[indexPath.row].price * Persistence.shared.realm.currency.rate, Persistence.shared.realm.currency.name)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Goods"
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    
    // MARK: - UI Actions
    func checkOut() {
        let checkOutViewController  = self.storyboard?.instantiateViewController(withIdentifier: "CheckOutViewController")
        self.navigationController?.pushViewController(checkOutViewController!, animated: true)
    }
    
}

