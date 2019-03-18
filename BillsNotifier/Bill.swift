//
//  Bill.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RealmSwift

class Bill: Object {
    
    enum Provider: String {
        case Claro, EPM
    }
    
    @objc dynamic var number: Int64 = 0
    @objc dynamic fileprivate var providerStr = "Claro"
    var provider: Provider {
        set {
            self.providerStr = newValue.rawValue
        }
        get {
            return Provider(rawValue: self.providerStr)!
        }
    }
    @objc dynamic var providerSubtype: Int = 0
    
    class var all: [Bill] {
        do {
            let realm = try Realm()
            let categories = realm.objects(Bill.self)
            return Array(categories)
            
        } catch _ {
            fatalError("REALM Error: error getting the bills")
        }
    }
    
    override static func primaryKey() -> String? {
        return "number"
    }
    
    convenience init(provider: Provider, number: Int64, providerSubtype: Int = 0) {
        self.init()
        self.provider = provider
        self.number = number
        self.providerSubtype = providerSubtype
    }

}
