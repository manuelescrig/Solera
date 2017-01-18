//
//  Basket.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import RealmSwift

// MARK: Basket model
class Basket: Object {
    
    dynamic var totalPrice = 0.0
    let items = List<Item>()
    
}
