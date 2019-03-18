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
        let headers = ["authToken": "J/IAcNWapi5SseDJukedKo0U5pJMzYXcOBM2lb41K89pj2bqpmy4DX+GT/4Y5N5C"]
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers).validate().responseArray { (response: DataResponse<[EPMBill]>) in
            complete(response.value)
        }
        
    }
    
}


class EPMBill: Mappable {
    
    var id = ""
    var contractNumber = ""
    var value: Double = 0
    var expireDate = Date()
    var city = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["NumeroFactura"]
        contractNumber <- map["NumeroContrato"]
        value <- map["ValorFactura"]
        expireDate <- (map["FechaVencimiento"], BillDateTransform())
        
    }
    
}
