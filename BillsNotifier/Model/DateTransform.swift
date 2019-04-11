//
//  ClaroDateFormatter.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import ObjectMapper

public class BillDateTransform: TransformType {
    
    
    public typealias Object = Date
    public typealias JSON = String
    
    public let dateFormatter: DateFormatter
    
    public init(_ format: String = "yyyy-MM-dd'T'hh:mm:ss",
                localeId: String = "en_US_POSIX",
                timeZone: TimeZone? = nil) {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: localeId)
        
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
    }
    
    ///to prevent bugs
    fileprivate func check(withFormat format: String? = nil, string dateStr: String)-> Date? {
        if let format = format {
            self.dateFormatter.dateFormat = format
        }
        return self.dateFormatter.date(from: dateStr)
    }
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        
        if let dateString = value as? String {
            
            if let date = check(string: dateString) {
                return date
            }else if let date = check(withFormat: "yyyy-MM-dd'T'hh:mm:ss", string: dateString) {
                return date
            }else if let date = check(withFormat: "MMM dd'/'yy", string: dateString) {
                return date
            }else if let date = check(withFormat: "dd-MMM-yyyy", string: dateString) {
                return date
            }
            
        }
        return nil
    }
    
    
    //    open func transformFromJSON(_ value: Any?) -> Date? {
    //        if let dateText = value as? String, let date = self.dateFormatter.date(from: dateText) {
    //            return date
    //        }
    //
    //        return nil
    //    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}

