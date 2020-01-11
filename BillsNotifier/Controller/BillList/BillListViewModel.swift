//
//  BillListViewModel.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RxSwift

class BillListViewModel {

    var bills = [Bill]()
    var billsGotten = Variable<[Any]>([])
    
    func setup() {
         bills = Bill.all
        
        getinfo(forBills: bills)
    }
    
    func getinfo(forBills bills: [Bill]) {
        
        bills.forEach { bill in
            if bill.provider == .Claro {
                Claro.nextBill(number: bill.number, accountType: Claro.AccountType(rawValue: bill.providerSubtype) ?? .mobile, complete: { claroBill in
                    if let claroBill = claroBill {
                        self.billsGotten.value.append(claroBill)
                        self.setupAlerts(forBill: claroBill)
                    }
                })
            } else if bill.provider == .EPM {
                EPM.nextBills(contractNumber: "\(bill.number)", complete: { epmBills in
                    if let epmBills = epmBills {
                        self.setupAlerts(forBills: epmBills)
                        self.billsGotten.value.append(contentsOf: epmBills)
                    }
                })
            } else if bill.provider == .Enel {
                Enel.nextBill(clientNumber: "\(bill.number)", complete: { enelBill in
                    if let enelBill = enelBill {
                        self.billsGotten.value.append(enelBill)
                        self.setupAlerts(forBill: enelBill)
                    }
                })
            }  else if bill.provider == .Acueducto {
                Acueducto.nextBill(complete: { acueductoBill in
                    if let acueductoBill = acueductoBill {
                        self.billsGotten.value.append(acueductoBill)
                        self.setupAlerts(forBill: acueductoBill)
                    }
                })
            }
            else if bill.provider == .Otro {
                self.setupAlerts(forBill: bill)
            }
        }
        
    }
    
    func setupAlerts(forBill bill: ClaroBill) {
        Notification.notifications(for: bill).forEach({ notification in
            LocalPushNotification.setup(for: notification)
        })

    }
    
    func setupAlerts(forBill bill: Bill) {
        Notification.notifications(for: bill).forEach({ notification in
            LocalPushNotification.setup(for: notification)
        })
        
    }
    
    func setupAlerts(forBills bills: [EPMBill]) {
        Notification.notifications(for: bills).forEach({ notification in
            LocalPushNotification.setup(for: notification)
        })
        
    }
    func setupAlerts(forBill bill: EnelBill) {
        Notification.notifications(for: bill).forEach({ notification in
            LocalPushNotification.setup(for: notification)
        })
        
    }
    func setupAlerts(forBill bill: AcueductoBill) {
        Notification.notifications(for: bill).forEach({ notification in
            LocalPushNotification.setup(for: notification)
        })
        
    }
    
}
