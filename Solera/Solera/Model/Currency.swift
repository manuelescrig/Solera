//
//  Currency.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import RealmSwift

// MARK: Currency model
class Currency: Object {
    
    dynamic var key = ""
    dynamic var name = ""
    dynamic var rate = 1.0
    
    override class func primaryKey() -> String? {
        return "key"
    }
    
}
