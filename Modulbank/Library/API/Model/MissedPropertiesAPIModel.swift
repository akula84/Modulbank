//
//  MissedPropertiesAPIModel.swift
//  MPM
//
//  Created by Alex Kozin on 05.07.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

class MissedPropertiesAPIModel: BaseModel {

    #if DEBUG

    override func cantFindKey(_ key: String, value: Any?) {
        //print("var \(key): \(type(of: value))")
    }

    #endif

}
