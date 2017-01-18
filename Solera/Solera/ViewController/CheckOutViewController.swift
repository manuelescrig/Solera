//
//  CheckOutViewController.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import RealmSwift

// MARK: CheckOutViewController class
class CheckOutViewController: UITableViewController {
    
    static let numberOfSectionsWithItems = 2
    static let numberOfSectionsWithoutItems = 1
    static let basketSection = 0

    var basket = Persistence.shared.realm.basket
    var notificationToken: NotificationToken?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CheckOut"
        
        // Add navigation bar button items
        let currency = UIBarButtonItem(title: "Currency", style: .plain, target: self, action: #selector(changeCurrency))
        navigationItem.rightBarButtonItem = currency
        
        // Update results
        notificationToken = Persistence.shared.realm.addNotificationBlock { notification, realm in
            self.basket = Persistence.shared.realm.basket
            self.tableView.reloadData()
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        if (basket.items.count > 0) {
            return CheckOutViewController.numberOfSectionsWithItems
        } else {
            return CheckOutViewController.numberOfSectionsWithoutItems
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == CheckOutViewController.basketSection) {
            return basket.items.count
        } else {
            return CheckOutViewController.numberOfSectionsWithoutItems
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == CheckOutViewController.basketSection) {
            let cell = tableView.dequeueReusableCell(withIdentifier: CheckOutItemTableViewCell.cellIdentifier, for: indexPath) as! CheckOutItemTableViewCell
            cell.item = basket.items[indexPath.row]
            cell.titleLabel?.text = basket.items[indexPath.row].name
            cell.subtitleLabel?.text = String(format: "%.2f  %@", basket.items[indexPath.row].price * Persistence.shared.realm.currency.rate, Persistence.shared.realm.currency.name)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CheckOutPriceTableViewCell.cellIdentifier, for: indexPath) as! CheckOutPriceTableViewCell
            cell.titleLabel?.text = "Total Price"
            cell.subtitleLabel?.text = String(format: "%.2f  %@", basket.totalPrice * Persistence.shared.realm.currency.rate, Persistence.shared.realm.currency.name)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == CheckOutViewController.basketSection) {
            return "Basket (\(basket.items.count))"
        } else {
            return "Price"
        }
    }
    
    
    // MARK: - UI Actions
    func changeCurrency() {
        let checkOutViewController  = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyViewController")
        let navigationController = UINavigationController.init(rootViewController: checkOutViewController!)
        self.present(navigationController, animated: true) {}
    }
    
}
