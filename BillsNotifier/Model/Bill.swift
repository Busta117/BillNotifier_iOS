//
//  Bill.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RealmSwift
import DateToolsSwift

class Bill: Object {
    
    enum Provider: String {
        case Claro, EPM, Enel, Acueducto, Otro
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
    
    // to set other(generic) bills notifier
    @objc dynamic var billTitle = ""
    @objc dynamic var billDescription = ""
    @objc dynamic var dueDate = Date(timeIntervalSince1970: 0)
    @objc dynamic var isMonthly = true //set a new due date for the next month if needed
    
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

    convenience init(id: Int64, title: String, description: String, dueDate: Date, isMonthly: Bool) {
        self.init()
        self.provider = Provider.Otro
        self.number = id
        self.billTitle = title
        self.billDescription = description
        self.dueDate = dueDate
        self.isMonthly = isMonthly
        
        
        // lets fix the due date if it is monthly
        let today = Date()
        if dueDate < today && isMonthly {
            let dateCurrentMonth = Date(year: dueDate.year, month: today.month, day: dueDate.day)
            if dateCurrentMonth < Date(year: today.year, month: today.month, day: today.day) {
                self.dueDate = dateCurrentMonth.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 1, years: 0))
            } else {
                self.dueDate = dateCurrentMonth
            }
        }
        
    }
    
    class func removeAll() {
        Realm.update {
            $0.delete($0.objects(Bill.self))
        }
    }
    
}
