//
//  NSDate + Utils.swift
//  Bunch-iOS
//
//  Created by Sergey Lyubeznov on 16/09/16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Foundation

extension Date {
    
    var stringMedium: String {
        return Formatter.medium.string(from: self as Date)
    }
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    var stringDDMMyyyy: String {
        return Formatter.formatterDDMMyyyy.string(from: self)
    }
    
    var stringddMMMyyyy: String {
        return Formatter.formatddMMMyyyy.string(from: self)
    }
    
    var stringddMMMMyyyy: String {
        return Formatter.formatddMMMMyyyy.string(from: self)
    }
    
    var stringdd_LLL_yyyy: String {
        return Formatter.formatdd_LLL_yyyy.string(from: self)
    }
    
    var stringddMMyyyyHHmm: String {
        return Formatter.formatddMMyyyyHHmm.string(from: self)
    }
    
    var string_LLLL_yyyy: String {
        return Formatter.format_LLLL_yyyy.string(from: self)
    }
    
    var stringyyyyxMMxdd: String {
        return Formatter.formatyyyyxMMxdd.string(from: self)
    }

}
