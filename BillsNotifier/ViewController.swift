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
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        
        viewModel.billsGotten.asObservable().subscribe(onNext: { bills in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        tableView.reloadData()
        
        
//        SVProgressHUD.show()
//        Claro.nextBill(number: 3003301001, accountType: .mobile) { bill in
//            SVProgressHUD.dismiss()
//            if let bill = bill {
//                Notification.notifications(for: bill).forEach({ notification in
//                    LocalPushNotification.setup(for: notification)
//                })
//
//                print("claro cel: \(CurrencyFormatter.shared.format(bill.value)!) date: \(bill.expireDate.format(with: "MMM dd"))")
//            }
//        }
//
//        Claro.nextBill(number: 04755909, accountType: .home) { bill in
//            SVProgressHUD.dismiss()
//            if let bill = bill {
//                Notification.notifications(for: bill).forEach({ notification in
//                    LocalPushNotification.setup(for: notification)
//                })
//                print("claro casa \(bill.city) - \(CurrencyFormatter.shared.format(bill.value)!) date: \(bill.expireDate.format(with: "MMM dd"))")
//            }
//        }
//
//        Claro.nextBill(number: 42777469, accountType: .home) { bill in
//            SVProgressHUD.dismiss()
//            if let bill = bill {
//                Notification.notifications(for: bill).forEach({ notification in
//                    LocalPushNotification.setup(for: notification)
//                })
//
//                print("claro casa \(bill.city) - \(CurrencyFormatter.shared.format(bill.value)!) date: \(bill.expireDate.format(with: "MMM dd"))")
//            }
//        }
//
//        EPM.nextBills(contractNumber: "2220049") { bills in
//            SVProgressHUD.dismiss()
//            if let bills = bills, bills.count > 0 {
//                Notification.notifications(for: bills).forEach({ notification in
//                    LocalPushNotification.setup(for: notification)
//                })
//                bills.forEach({ bill in
//                    print("EPM \(CurrencyFormatter.shared.format(bill.value)!) date: \(bill.expireDate.format(with: "MMM dd"))")
//                })
//            }
//        }
        
        
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(viewModel.bills.count, viewModel.billsGotten.value.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bill = viewModel.bills[indexPath.row]
        let billsGotten = viewModel.billsGotten.value.filter { (billG) -> Bool in
            if let billG = billG as? ClaroBill, billG.accountId == "\(bill.number)" {
                return true
            } else if let billG = billG as? EPMBill, billG.contractNumber == "\(bill.number)" {
                return true
            }
            return false
        }
        
        
        if billsGotten.count > 0 {
           
            let billGotten = billsGotten.first!
            if let billGotten = billGotten as? ClaroBill {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BillListClaroTableViewCell", for: indexPath) as! BillListClaroTableViewCell
                cell.setup(billGotten)
                return cell
            } else if let billGotten = billGotten as? EPMBill {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BillListEpmTableViewCell", for: indexPath) as! BillListEpmTableViewCell
                cell.setup(billGotten)
                return cell
            }
            
        } else {
            
            if bill.provider == .Claro {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BillListClaroTableViewCell", for: indexPath) as! BillListClaroTableViewCell
                cell.setup(bill)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BillListEpmTableViewCell", for: indexPath) as! BillListEpmTableViewCell
                cell.setup(bill)
                return cell
            }
            
            
        }
        
        return UITableViewCell()
        
        
        
    }
    
    
}

