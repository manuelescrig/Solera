//
//  Settings.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import UIKit

// MARK: User settings instance
class Settings {
    
    static let shared = Settings()
    private init() {}
    
    static let currencyReference = "selectedCurrency"
    static let launchedReference = "launchedBefore"
    
    // Currency Settings
    func setCurrency(_ currency: String) {
        UserDefaults.standard.set(currency, forKey: Settings.currencyReference)
    }
    
    func getCurrency() -> String {
        return UserDefaults.standard.string(forKey: Settings.currencyReference)!
    }
    
    // App first launch Settings
    func setLaunched() {
        UserDefaults.standard.set(true, forKey: Settings.launchedReference)
    }
    
    func hasLaunched() -> Bool {
        return UserDefaults.standard.bool(forKey: Settings.launchedReference)
    }
    
}
