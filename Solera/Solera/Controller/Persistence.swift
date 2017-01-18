//
//  Persistence.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import RealmSwift

// MARK: Persistenc instance
class Persistence {
    
    static let shared = Persistence()
    private init() {}
    
    let realm = try! Realm()
    
}

// MARK: Application/View state
extension Realm {
    var items: Results<Item> {
        return objects(Item.self)
    }
    
    var basket: Basket {
        return objects(Basket.self).first!
    }
    
    var currency: Currency {
        return objects(Currency.self).filter("key = %@", Settings.shared.getCurrency()).first!
    }
    
    var currencies: Results<Currency> {
        return objects(Currency.self)
    }
}

// MARK: Actions
extension Realm {
    
    // Items
    func addItem(name: String, price: Double) {
        do {
            try write {
                let item = Item()
                item.name = name
                item.price = price
                add(item)
            }
        } catch {
            print("Action failed: \(error)")
        }
    }    
    
    func createBasket() {
        do {
            try write {
                let basket = Basket()
                basket.totalPrice = 0.0
                add(basket)
            }
        } catch {
            print("Action failed: \(error)")
        }
    }
    
    // Basket
    func addToBasket(item: Item) {
        do {
            try write {
                basket.items.append(item)
                basket.totalPrice += item.price
            }
        } catch {
            print("Action failed: \(error)")
        }
    }
    
    func removeFromBasket(item: Item) {
        do {
            try write {
                let index = basket.items.index(of: item)
                basket.totalPrice -= item.price
                basket.items.remove(objectAtIndex: index!)
                
            }
        } catch {
            print("Action failed: \(error)")
        }
    }
    
    // Currency
    func addCurrency(key:String, name: String) {
        do {
            try write {
                let currency = Currency()
                currency.key = key
                currency.name = name
                add(currency)
            }
        } catch {
            print("Action failed: \(error)")
        }
    }
    
    func updateCurrency(key:String, rate: Double) {
        do {
            try write {
                create(Currency.self, value: ["key": key, "rate": rate], update: true)
            }
        } catch {
            print("Action failed: \(error)")
        }
    }
    
}
