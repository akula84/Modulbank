//
//  KeychainAdapter.swift
//  MPM
//
//  Created by Bell Integrator on 01/02/2019.
//  Copyright © 2019 Bell Integrator. All rights reserved.
//

import Foundation


final class KeychainAdapter {
    enum Error: Swift.Error {
        case stringToDataConversionFailed
        case dataToStringConversionFailed
        case operationNotSuccessful(status: OSStatus)
    }
    
    let tagPrefix: String
    
    init(tagPrefix: String) {
        self.tagPrefix = tagPrefix
    }
    
    func tag(for key: String) -> String {
        return tagPrefix + "." + key
    }
    
    func getValue(for key: String) throws -> String? {
        let tag = self.tag(for: key)
        guard let tagData = tag.data(using: .utf8) else {
            throw KeychainAdapter.Error.stringToDataConversionFailed
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tagData,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        if status == errSecItemNotFound {
            return nil
        }
        if status != noErr {
            throw KeychainAdapter.Error.operationNotSuccessful(status: status)
        }
        guard let data = result as? Data,
            let string = String(data: data, encoding: .utf8) else {
                throw KeychainAdapter.Error.dataToStringConversionFailed
        }
        return string
    }
    
    func set(value: String?, for key: String) throws {
        let tag = self.tag(for: key)
        guard let tagData = tag.data(using: .utf8) else {
            throw KeychainAdapter.Error.stringToDataConversionFailed
        }
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tagData
        ]
        var status = SecItemDelete(query as CFDictionary)
        if status != noErr && status != errSecItemNotFound {
            throw KeychainAdapter.Error.operationNotSuccessful(status: status)
        }
        guard let value = value else {
            return
        }
        guard let valueData = value.data(using: .utf8) else {
            throw KeychainAdapter.Error.stringToDataConversionFailed
        }
        query[kSecValueData as String] = valueData
        
        status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainAdapter.Error.operationNotSuccessful(status: status)
        }
    }
}
