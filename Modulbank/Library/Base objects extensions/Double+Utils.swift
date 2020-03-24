//
//  Double+Utils.swift
//  MPM
//
//  Created by Артем Кулагин on 16/10/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension Double {
    
    var fileSizeMB: Double {
        return self / (1024 * 1024)
    }
    
    var stringComma: String {
        return (self as NSNumber).stringComma
    }
    
    var humanReadableFileSize: String {
        guard self > 0 else {
            return "0 \(L10n.FileSize.bytes)"
        }
        
        let suffixes = [
            L10n.FileSize.bytes, L10n.FileSize.kbytes,
            L10n.FileSize.mbytes, L10n.FileSize.gbytes,
            L10n.FileSize.tbytes
        ]
        
        let k: Double = 1000
        let i = floor(log(self) / log(k))
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = i < 3 ? 0 : 1
        numberFormatter.numberStyle = .decimal
        
        let numberString = numberFormatter.string(from: NSNumber(value: self / pow(k, i))) ?? L10n.error
        guard Int(i) < suffixes.count else {
            return L10n.error
        }
        
        let suffix = suffixes[Int(i)]
        return "\(numberString) \(suffix)"
    }
    
    var nsnumber: NSNumber {
        return self as NSNumber
    }
}
