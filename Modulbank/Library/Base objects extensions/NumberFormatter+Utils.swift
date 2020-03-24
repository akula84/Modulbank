//
//  NumberFormatter+Utils.swift
//  MPM
//
//  Created by Артем Кулагин on 16/10/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    static var stringComma: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        return formatter
    }
}
