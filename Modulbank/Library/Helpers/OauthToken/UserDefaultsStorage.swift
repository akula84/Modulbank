//
//  UserDefaultsStorage.swift
//  MPM
//
//  Created by Артем Кулагин on 17/12/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

protocol StorageTokenProtocol {
    
    var oauthToken: OauthToken? {get set}
    
}

class UserDefaultsStorage: StorageTokenProtocol {
    
    var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    var accessToken: String? {
        get {
            return userDefaults[#function]
        }
        set {
            userDefaults[#function] = newValue
        }
    }
    
    var expirationDate: Date? {
        get {
            return userDefaults[#function]
        }
        set {
            userDefaults[#function] = newValue
        }
    }
   
    var userRole: String? {
        get {
            return userDefaults[#function]
        }
        set {
            userDefaults[#function] = newValue
        }
    }
    
    var oauthToken: OauthToken? {
        get {
            let token = OauthToken()
            token.accessToken = accessToken
            token.expirationDate = expirationDate
            token.userRole = userRole
            return token
        }
        set {
            accessToken = newValue?.accessToken
            expirationDate = newValue?.expirationDate
            userRole = newValue?.userRole
            userDefaults.synchronize()
        }
    }
    
    static let shared = UserDefaultsStorage()
}
