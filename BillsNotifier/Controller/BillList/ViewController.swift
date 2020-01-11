//
//  ViewController.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import SVProgressHUD
import DateToolsSwift
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    var viewModel = BillListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setup()
        
        title = "Bill Notifier"
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        
        viewModel.billsGotten.asObservable().subscribe(onNext: { bills in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        tableView.reloadData()
        
    }

    
    @objc func addBill() {
        
    }

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(viewModel.bills.count, viewModel.billsGotten.value.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillListTableViewCell", for: indexPath) as! BillListTableViewCell
        
        let bill = viewModel.bills[indexPath.row]
        let billsGotten = viewModel.billsGotten.value.filter { (billG) -> Bool in
            if let billG = billG as? ClaroBill, billG.accountId == "\(bill.number)" {
                return true
            } else if let billG = billG as? EPMBill, billG.contractNumber == "\(bill.number)" {
                return true
            } else if let billG = billG as? EnelBill, billG.clientNumber == "\(bill.number)" {
                return true
            } else if let billG = billG as? AcueductoBill, billG.id == "\(bill.number)" {
                return true
            }
            return false
        }
        
        
        
        if billsGotten.count > 0 {
           
            let billGotten = billsGotten.first!
            if let billGotten = billGotten as? ClaroBill {
                cell.setup(billGotten)
            } else if let billGotten = billGotten as? EPMBill {
                cell.setup(billGotten)
            } else if let billGotten = billGotten as? EnelBill {
                cell.setup(billGotten)
            } else if let billGotten = billGotten as? AcueductoBill {
                cell.setup(billGotten)
            } else {
                assertionFailure("no deberia entrar aca")
                cell.setup(bill)
            }
            
        } else {
            cell.setup(bill)
        }
        
        return cell
        
    }
    
    
}

