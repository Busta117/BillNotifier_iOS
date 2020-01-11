//
//  Regex.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 8/1/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import Foundation

open class Regex {
    public let internalExpression: NSRegularExpression
    public let pattern: String
    
    public init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = try! NSRegularExpression (pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
    }
    
    public init(regularExpression: NSRegularExpression) {
        self.pattern = ""
        self.internalExpression = regularExpression
    }
    
    open func matched(in input: String) -> Bool{
        
        let matches = internalExpression.matches(in:input, options: NSRegularExpression.MatchingOptions.reportCompletion, range:NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
    
    open func match(_ value: String) -> String? {
        
        let matches = internalExpression.matches(in: value, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, value.count))
        
        let arr = matches.map {
            String(value[Range($0.range, in: value)!])
        }
        return arr.first
        
    }
    
    open func matches(_ value: String) -> [String] {
        
            let matches = internalExpression.matches(in: value, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, value.count))
            
            let arr = matches.map {
                String(value[Range($0.range, in: value)!])
            }
            return arr
    }
    
    open func matchesWithRange(_ value: String) -> [(value: String, range: NSRange)] {
        
            let matches = internalExpression.matches(in: value, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, value.count))
            
            let arr = matches.map {
                (value: String(value[Range($0.range, in: value)!]), range: $0.range)
            }
            return arr
        
    }
    
}
