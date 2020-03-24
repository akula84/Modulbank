//
//  KeychainTokenStorage.swift
//  MPM
//
//  Created by Bell Integrator on 01/02/2019.
//  Copyright © 2019 Bell Integrator. All rights reserved.
//

import Foundation


final class KeychainTokenStorage: StorageTokenProtocol {
    let keychain: KeychainAdapter
    init() {
        keychain = KeychainAdapter(tagPrefix: "ru.beeline.mwp")
    }
    
    private enum Keys: String {
        case accessToken, expirationDate, userRole
    }
    
    private subscript (key: Keys) -> String? {
        get {
            do {
               return try keychain.getValue(for: key.rawValue)
            } catch {
                return nil
            }
        }
        set {
            do {
                try keychain.set(value: newValue, for: key.rawValue)
            } catch {}
        }
    }
    
    static let shared = KeychainTokenStorage()
    
    var oauthToken: OauthToken? {
        get {
            let token = OauthToken()
            token.accessToken = self[.accessToken]
            let dateString = self[.expirationDate]
            token.expirationDate = dateString == nil ? nil : Formatter.iso8601.date(from: dateString!)
            token.userRole = self[.userRole]
            return token
        }
        set {
            self[.accessToken] = newValue?.accessToken
            self[.expirationDate] = newValue?.expirationDate?.iso8601
            self[.userRole] = newValue?.userRole
        }
    }
}
