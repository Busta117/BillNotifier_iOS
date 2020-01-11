//
//  BillListTableviewCell.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 4/11/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import DateToolsSwift

class BillListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var billNumeberLabel: UILabel!
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = "-"
        serviceTypeLabel.text = "-"
        billNumeberLabel.text = "-"
        dateLabel.text = "-"
        valueLabel.text = "-"

    }
    
    func setup(_ bill: Bill) {
        titleLabel.text = bill.provider.rawValue
        serviceTypeLabel.text = ""
        billNumeberLabel.text = "\(bill.number)"
        dateLabel.text = ""
        valueLabel.text = ""
        
        if bill.provider == .Otro {
            titleLabel.text = bill.billTitle
            serviceTypeLabel.text = bill.billDescription
            billNumeberLabel.text = "--"
            dateLabel.text = bill.dueDate.format(with: "MMM dd yyyy")
            dateLabel.textColor = UIColor.black
            if bill.dueDate.isToday || bill.dueDate > Date() {
                dateLabel.textColor = UIColor(red: 144/255, green: 179/255, blue: 109/255, alpha: 1)
            } else if bill.dueDate < Date() {
                dateLabel.textColor = UIColor(red: 193/255, green: 75/255, blue: 75/255, alpha: 1)
            }
            valueLabel.text = "N/A"
        }
    }
    
    func setup(_ bill: EPMBill) {
        titleLabel.text = "EPM"
        if bill.paid {
            titleLabel.text = titleLabel.text! + " (Paid)"
        }
        serviceTypeLabel.text = "Servicios Publicos"
        billNumeberLabel.text = "\(bill.id) (\(bill.contractNumber))"
        dateLabel.text = bill.expireDate.format(with: "MMM dd yyyy")
        dateLabel.textColor = UIColor.black
        if bill.expireDate.isToday || bill.expireDate > Date() {
            dateLabel.textColor = UIColor(red: 144/255, green: 179/255, blue: 109/255, alpha: 1)
        } else if bill.expireDate < Date() {
            dateLabel.textColor = UIColor(red: 193/255, green: 75/255, blue: 75/255, alpha: 1)
        }
        valueLabel.text = CurrencyFormatter.shared.format(bill.value)
        
    }
    
    func setup(_ bill: ClaroBill) {
        titleLabel.text = "Claro"
        serviceTypeLabel.text = bill.accountType == .home ? "Hogar(\(bill.city))" : "Celular"
        billNumeberLabel.text = bill.accountId
        dateLabel.text = bill.expireDate.format(with: "MMM dd yyyy")
        dateLabel.textColor = UIColor.black
        if bill.expireDate.isToday || bill.expireDate > Date() {
            dateLabel.textColor = UIColor(red: 144/255, green: 179/255, blue: 109/255, alpha: 1)
        } else if bill.expireDate < Date() {
            dateLabel.textColor = UIColor(red: 193/255, green: 75/255, blue: 75/255, alpha: 1)
        }
        valueLabel.text = CurrencyFormatter.shared.format(bill.value)
    }
    
    func setup(_ bill: EnelBill) {
        titleLabel.text = "Enel-Codensa"
        if bill.paid {
            titleLabel.text = titleLabel.text! + " (Paid)"
        }
        serviceTypeLabel.text = "Energia"
        billNumeberLabel.text = bill.clientNumber
        dateLabel.text = bill.dueDate.format(with: "MMM dd yyyy")
        dateLabel.textColor = UIColor.black
        if bill.dueDate.isToday || bill.dueDate > Date() {
            dateLabel.textColor = UIColor(red: 144/255, green: 179/255, blue: 109/255, alpha: 1)
        } else if bill.dueDate < Date() {
            dateLabel.textColor = UIColor(red: 193/255, green: 75/255, blue: 75/255, alpha: 1)
        }
        valueLabel.text = CurrencyFormatter.shared.format(Double(bill.value))
    }
    
    func setup(_ bill: AcueductoBill) {
        titleLabel.text = "Acueducto"
        serviceTypeLabel.text = "Agua"
        billNumeberLabel.text = bill.id
        dateLabel.text = bill.dueDate.format(with: "MMM dd yyyy")
        dateLabel.textColor = UIColor.black
        if bill.dueDate.isToday || bill.dueDate > Date() {
            dateLabel.textColor = UIColor(red: 144/255, green: 179/255, blue: 109/255, alpha: 1)
        } else if bill.dueDate < Date() {
            dateLabel.textColor = UIColor(red: 193/255, green: 75/255, blue: 75/255, alpha: 1)
        }
        valueLabel.text = CurrencyFormatter.shared.format(bill.value)
    }
    
}

