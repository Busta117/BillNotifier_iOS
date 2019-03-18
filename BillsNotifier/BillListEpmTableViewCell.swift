//
//  BillListEpmTableViewCell.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

class BillListEpmTableViewCell: UITableViewCell {

    @IBOutlet weak var billNumeberLabel: UILabel!
    @IBOutlet weak var contractNumberLabel: UILabel!
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
        billNumeberLabel.text = "-"
        contractNumberLabel.text = "\(bill.number)"
        dateLabel.text = ""
        valueLabel.text = ""
    }
    
    func setup(_ bill: EPMBill) {
        billNumeberLabel.text = "\(bill.id)"
        contractNumberLabel.text = bill.contractNumber
        dateLabel.text = bill.expireDate.format(with: "MMM dd yyyy")
        valueLabel.text = CurrencyFormatter.shared.format(bill.value)
    }

}
