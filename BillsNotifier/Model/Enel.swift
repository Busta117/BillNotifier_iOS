//
//  Enel.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 7/31/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import DateToolsSwift

class Enel {

    class func nextBill(clientNumber: String, complete: @escaping (EnelBill?)->()) {
        
        let url = "https://www.enel.com.co/es/personas/servicio-al-cliente/factura-express.mdwedge.getHistoricalInvoices.html"
        let params: [String: Any] = ["supplyCode": clientNumber, "area": "public_co"]
        //let headers = ["authToken": "/PM2NlYP+mEpdSRLsUTIDaerkoz2P1BnKZNxYlH588hH3YPWdXwtGZ9rEryTV1Gu"]
        Alamofire.request(url, method: .post, parameters: params).validate().responseArray(keyPath: "invoiceList") { (response: DataResponse<[EnelBill]>) in
            if let bills = response.value, let lastBill = bills.first {
                lastBill.clientNumber = clientNumber
                complete(lastBill)
            } else {
                complete(nil)
            }
        }
    }
    
}


class EnelBill: Mappable {
    
    var id = ""
    var clientNumber = ""
    var value: Int = 0
    private var valueStr = "" {
        didSet {
            self.value = Int(valueStr)!
        }
    }
    var shipmentDate = Date(timeIntervalSince1970: 0) {
        didSet{
            dueDate = Date(year: shipmentDate.year, month: shipmentDate.month, day: 1)
            dueDate = dueDate.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 1, years: 0))
        }
    }
    var dueDate = Date(timeIntervalSince1970: 0)
    private var state = "" {
        didSet {
            if state == "Pagada" {
                paid = true
            }
        }
    }
    var paid = false
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["invoiceNumber"]
        valueStr <- map["amount"]
        state <- map["invoiceState"]
        shipmentDate <- (map["shipmentDate"], BillDateTransform("dd/MM/yyyy"))
        
    }
    
}
