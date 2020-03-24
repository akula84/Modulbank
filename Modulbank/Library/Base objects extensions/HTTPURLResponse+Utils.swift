//
//  HTTPURLResponse+Utils.swift
//  MPM
//
//  Created by Артем Кулагин on 13/12/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    var isUnauthorized: Bool {
        return statusCode == 401
    }
}
