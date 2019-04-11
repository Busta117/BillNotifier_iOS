//
//  EPM.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class EPM {
    
    class func nextBills(contractNumber: String, complete: @escaping (_: [EPMBill]?)->()) {
        
        let url = "https://appmovil.epm.com.co/WSAppMovil/V2_0/api/Factura/ConsultaDeContratos"
        let params: [String: Any] = ["numeroContrato": contractNumber]
        let headers = ["authToken": "/PM2NlYP+mEpdSRLsUTIDaerkoz2P1BnKZNxYlH588hH3YPWdXwtGZ9rEryTV1Gu"]
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers).validate().responseArray { (response: DataResponse<[EPMBill]>) in
            complete(response.value)
        }
        
    }
    
}


class EPMBill: Mappable {
    
    var id = ""
    var contractNumber = ""
    var value: Double = 0
    var expireDate = Date(timeIntervalSince1970: 0)
    var city = ""
    var paid = false
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["DocumentoReferencia"]
        contractNumber <- map["NumeroContrato"]
        value <- map["ValorFactura"]
        expireDate <- (map["FechaVencimiento"], BillDateTransform())
        paid <- map["EstadoPagoFactura"]
        
    }
    
}
