//
//  Parser+KeyConversion.swift
//  SwiftAPIWrapper
//
//  Created by Alexander Kozin on 04.04.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Darwin

extension Parser {

    func className(for value: Any, from key: String) -> String {
        //Drop 's' for Array
        let keyToParse = value is [Any] ? String(key.dropLast()) : key
        return keyFromBackendKey(keyToParse, capitlizeFirst: true)
    }
    
    func propertyName(from key: String) -> String {
        return keyFromBackendKey(key, capitlizeFirst: false)
    }

    func keyFromBackendKey(_ key: String, capitlizeFirst: Bool) -> String {
        var resultKey = ""

        let characters = key.unicodeScalars

        var shouldCapitlize = capitlizeFirst

        let snake = UnicodeScalar("_")

        for var char: UnicodeScalar in characters {
            if char == snake {
                shouldCapitlize = true
            } else {
                if shouldCapitlize {
                    char = UnicodeScalar(UInt32(toupper(Int32(char.value))))!
                    shouldCapitlize = false
                }

                resultKey.append(Character(char))
            }

        }

        return resultKey
    }
    
}
