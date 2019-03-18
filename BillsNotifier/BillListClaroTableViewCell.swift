//
//  BillListClaroTableViewCell.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import DateToolsSwift

class BillListClaroTableViewCell: UITableViewCell {

    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ bill: Bill) {
        accountTypeLabel.text = Claro.AccountType(rawValue: bill.providerSubtype)! == .home ? "Hogar" : "Celular"
        accountNumberLabel.text = "\(bill.number)"
        dateLabel.text = ""
        valueLabel.text = ""
    }
    
    func setup(_ bill: ClaroBill) {
        accountTypeLabel.text = bill.accountType == .home ? "Hogar(\(bill.city))" : "Celular"
        accountNumberLabel.text = bill.accountId
        dateLabel.text = bill.expireDate.format(with: "MMM dd yyyy")
        valueLabel.text = CurrencyFormatter.shared.format(bill.value)
    }

}
