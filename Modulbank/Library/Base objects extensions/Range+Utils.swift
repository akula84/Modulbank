//
//  Range+Utils.swift
//  MPM
//
//  Created by Alexander on 10.09.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation


extension Range where Bound == Int {
    var length: Int {
        return upperBound - lowerBound
    }
}
