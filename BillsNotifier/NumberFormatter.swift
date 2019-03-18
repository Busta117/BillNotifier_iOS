//
//  NumberFormatter.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/8/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

class CurrencyFormatter: NumberFormatter {
    static let shared = CurrencyFormatter()
    override init() {
        super.init()
        locale = Locale(identifier: "en_CO")
        currencySymbol = "$ "
        currencyDecimalSeparator = "."
        numberStyle = .currency
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension NumberFormatter {
    func format(_ value: Float) -> String? {
        let formatter = CurrencyFormatter.shared
        return formatter.string(from: NSNumber(value: value))
    }
    func format(_ value: Double) -> String? {
        let formatter = CurrencyFormatter.shared
        return formatter.string(from: NSNumber(value: value))
    }
}

extension Float {
    var currencyValue: String? {
        return CurrencyFormatter.shared.format(self)
    }
}

extension Int {
    var currencyValue: String? {
        return CurrencyFormatter.shared.format(Float(self))
    }
}
