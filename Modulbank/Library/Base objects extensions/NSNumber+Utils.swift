//
//  NSNumber+Utils.swift
//  MPM
//
//  Created by Артем Кулагин on 16/10/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension NSNumber {
    
    var stringComma: String {
        let formatter = NumberFormatter.stringComma
        let text = formatter.string(from: self)
        return text ?? String(describing: self)
    }

    var string: String {
        return String(describing: self)
    }
}
