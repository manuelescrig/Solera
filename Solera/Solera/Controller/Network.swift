//
//  Network.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import Alamofire
import SwiftyJSON

// MARK: Network instance
class Network {
    
    static let shared = Network()
    private init() {}
    
    static let currencyAPIKey = "71c64ff042421cf45dffee42d510c65f"
    static let currencyRequestUrl = "http://apilayer.net/api/live?access_key=" + Network.currencyAPIKey + "&currencies=USD,AUD,CAD,GBP,EUR&format=1"
    
    func updateCurrencies(handler:@escaping (_ succes:Bool) -> Void ) {
        
        Alamofire.request(Network.currencyRequestUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (key, object) in json["quotes"] {
                    Persistence.shared.realm.updateCurrency(key: key, rate: object.doubleValue)
                }
                handler(true)
                
            case .failure(let error):
                print(error)
                handler(false)
                
            }
        }
    }
    
}
