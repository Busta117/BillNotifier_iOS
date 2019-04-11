//
//  Claro.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import RealmSwift

class Claro {
    
    enum AccountType: Int {
        case mobile = 3
        case home = 1
    }
    
    class func nextBill(number: Int64, accountType: AccountType, complete: @escaping (_: ClaroBill?)->()) {
        
        let url = "https://apiselfservice.co/api/index.php/v1/rest/getCustomerDocuments.json"
        let params = ["data": ["numeroCuenta": number,
                               "LineOfBusiness": accountType.rawValue,
                               "canal": "hogar"]]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseObject { (response: DataResponse<ClaroBill>) in
            if let bill = response.value, bill.id > 0 {
                bill.accountType = accountType
                bill.accountId = "\(number)"
                complete(bill)
            } else {
                complete(nil)
            }
            
        }
        
    }
    
}

class ClaroBill: Mappable {
    
    var id: Int64 = 0
    var accountId = ""
    var valueStr = "" {
        didSet {
            value = Double(valueStr) ?? 0
        }
    }
    var value: Double = 0
    var expireDate = Date(timeIntervalSince1970: 0)
    var city = ""
    var accountType = Claro.AccountType.mobile
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["response.facturaActual.numeroFactura"]
        valueStr <- map["response.facturaActual.valor"]
        expireDate <- (map["response.facturaActual.pagoOportuno"], BillDateTransform(localeId: "es"))
        city <- map["response.usuario.ciudad"]
        
    }
    
    
}
