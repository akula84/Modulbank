//
//  BaseModel.swift
//  Day
//
//  Created by Alexander Kozin on 17.01.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Foundation

class BaseModel: NSObject {

    @objc
    var id: NSNumber = 0

    required override init() {
    }

    func cantFindKey(_ key: String, value: Any?) {

    }
    
    func associateEnum<E: RawRepresentable, M: BaseModel>(with keyPath: KeyPath<M, NSNumber?>) -> E? where E.RawValue == Int, E: CustomStringConvertible {
        guard let number = self[keyPath: keyPath as AnyKeyPath] as? NSNumber else {
            return nil
        }
        return E(rawValue: number.intValue)
    }
}


extension BaseModel {
    enum YesNo: Int, CustomStringConvertible {
        case no = 0, yes = 1
        var description: String {
            switch self {
            case .no: return L10n.no
            case .yes: return L10n.yes
            }
        }
    }
}
