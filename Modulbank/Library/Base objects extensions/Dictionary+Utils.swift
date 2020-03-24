//
//  Dictionary.swift
//  MPM
//
//  Created by Артем Кулагин on 24.09.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension Dictionary {
    var jsonString: String {
        guard let jsonData = jsonData else {
            return ""
        }
        return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    }

    var jsonStringData: Data? {
        return jsonString.data(using: .utf8)
    }

    var hexEncodedString: String? {
        return jsonStringData?.hexEncodedString()
    }

    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    func valueAt(_ key: String?) -> Any? {
        guard let key = key else {
            return nil
        }
        let dict = self as? [String: Any]
        return dict?[key]
    }

    mutating func merge(with dictionary: Dictionary?) {
        guard let dictionary = dictionary else {
            return
        }
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
}

extension Dictionary where Key == String, Value == Any {
    mutating func setIfNotZero(_ key: String?, intValue: Int?) {
        guard let key = key,
            let value = intValue,
            value != 0 else {
            return
        }
        self[key] = value
    }

    mutating func setIfNotZero(_ key: String?, numberValue: NSNumber?) {
        setIfNotZero(key, intValue: numberValue?.intValue)
    }
}
