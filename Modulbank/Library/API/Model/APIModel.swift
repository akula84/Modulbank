//
//  APIModel.swift
//  SwiftAPIWrapper
//
//  Created by Alexander Kozin on 27.03.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Foundation

//WARNING: change to app-specific base model
typealias APIModel = BaseModel

// Parcing process
extension APIModel {

    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
        cantFindKey(key, value: value )
    }

}

// Mapping
extension APIModel {

    @objc
    class func classMapping() -> [String: String] {
        return [:]
    }

    @objc
    class func propertyMapping() -> [String: String] {
        return [:]
    }

}
