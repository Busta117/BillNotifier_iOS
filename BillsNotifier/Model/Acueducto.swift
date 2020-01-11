//
//  Acueducto.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 8/1/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class Acueducto {

    
    class func nextBill(complete: @escaping (AcueductoBill?)->()) {
        
        let url = "https://www.acueducto.com.co/wasap02/RegistroWEB/privada/agregarCtas.xhtml"
        let params: [String: Any] = ["javax.faces.partial.ajax": "true",
                                     "javax.faces.partial.render": "detailForm:panelDetail",
                                     "javax.faces.ViewState": "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"]
        
        let headers: HTTPHeaders = ["Accept": "application/xml, text/xml, */*; q=0.01",
                                      "Cookie" : "AMWEBJCT!%2Fwasapp!JSESSIONID=0000LQppICWI7sDLxBNTZKWp7Y8:-1; SL_ClassKey=0.1.1; AMWEBJCT!%2Fwasprd!JSESSIONID=0000UDk7ICPwrTiDhMQqcCDI336:-1; WEBSEALS=AEl7RQZkqMAzM44CQt3FFw$$; __utma=137388192.1139211748.1564700532.1564700532.1564700532.1; __utmc=137388192; __utmz=137388192.1564700532.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); _ga=GA1.3.1139211748.1564700532; _gid=GA1.3.204454095.1564700726; AMWEBJCT!%2Fguatoc!ACUEMORTAVS_80=AxgBJPIDE6zp/3x9YXBYKA$$; IV_JCT=%2Fwasap02; __utmb=137388192.3.10.1564700532; PD-H-SESSION-ID=1_POD639INHznubldAk3WWwRk/vdYjtzeh4JL3LXJoo36rkbQ6rcA=_AAAAAAA=_epkuNIQV5MQyeph6HyQbuA9TUyM=; JSESSIONID=0000sRfTpRlVhxZka0Jvy8aAs5O:-1; oam.Flash.RENDERMAP.TOKEN=8j6g81krr"]
        
        
        //let headers = ["authToken": "/PM2NlYP+mEpdSRLsUTIDaerkoz2P1BnKZNxYlH588hH3YPWdXwtGZ9rEryTV1Gu"]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseString { response in
            if let value = response.result.value {
                
                var json = [String: Any]()
                
                let matches = Regex("<tr[\\s\\S]*?<\\/tr>").matches(value)
                for match in matches {
                    var values = Regex("<td[\\s\\S]*?<\\/td>").matches(match)
                    values = values.map({$0.replacingOccurrences(of: "<td>", with: "")})
                    values = values.map({$0.replacingOccurrences(of: "</td>", with: "")})
                    values = values.map({$0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)})
                    
                    json[values.first!] = values.last ?? ""
                }
                
                let bill = AcueductoBill(JSON: json)
                complete(bill)
                
            } else {
                complete(nil)
            }
            
        }
    }
    
}


class AcueductoBill: Mappable {

    var id = ""
    var value: Double = 0
    private var valueStr = "" {
        didSet {
            value = Double(valueStr.replacingOccurrences(of: ".", with: "")) ?? 0
        }
    }

    var dueDate = Date(timeIntervalSince1970: 0)
    

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id = map.JSON["No. cuenta:"] as? String ?? ""
        valueStr <- map["Valor total: $"]
        dueDate <- (map["Fecha limite de pago:"],  BillDateTransform("MMM/dd/yyyy", localeId: "es"))

    }
}
