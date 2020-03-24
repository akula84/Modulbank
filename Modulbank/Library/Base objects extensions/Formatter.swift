//
//  Formatter.swift
//  MPM
//
//  Created by Артем Кулагин on 26/11/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    static let formatterDDMMyyyy: DateFormatter = {
        return format("dd.MM.yyyy")
    }()
    
    static let formatterDDMMyyy: DateFormatter = {
        return format("dd.MM.yyy")
    }()
    
    static let formatyyyyxMMxdd: DateFormatter = {
        return format("yyyy-MM-dd")
    }()
    
    static let medium: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }()
    
    static let formatddxMMxyyyy: DateFormatter = {
        return format("dd-MM-yyyy")
    }()
    
    static let formatdd_LLL_yyyy: DateFormatter = {
        return format("dd LLL yyyy")
    }()
    
    static let format_LLLL_yyyy: DateFormatter = {
        return format("LLLL yyyy")
    }()
    
    static let formatddMMyyyyHHmm: DateFormatter = {
        return format("dd.MM.yyyy, HH:mm")
    }()
    
    static let formatddMMMyyyy: DateFormatter = {
        return format("dd MMM, yyyy")
    }()
    
    static let formatddMMMMyyyy: DateFormatter = {
        return format("dd MMMM, yyyy")
    }()
    
    static func format(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
