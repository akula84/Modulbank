//
//  AuthManager.swift
//  BaseApp
//
//  Created by Alexander Tarasov on 26/06/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation
import UIKit

public typealias AuthManagerGoOnlineCompletion = (_ success: Bool, _ error: Error?) -> Void

class AuthManager {
    
    static var tokenStorage: StorageTokenProtocol = UserDefaultsStorage.shared

    // Oauth Token
    static var oauthToken: OauthToken? {
        get {
            return tokenStorage.oauthToken
        }
        set {
            tokenStorage.oauthToken = newValue
        }
    }
    
    // Access Token
    static var accessToken: String? {
        return oauthToken?.accessToken
    }
    
    // Login method
    static func login(username: String, password: String, completion: @escaping AuthManagerGoOnlineCompletion) {
        let api = PostAuthAPI(username: username, password: password)
        api.sendRequestWithCompletion { (result, error, _) in
            guard let token = result as? OauthToken else {
                completion(false, error)
                return
            }
            
            if let errorName = token.error,
            let errorDescription = token.errorDescription {
                let apiError = NSError.error401(error: errorName, message: errorDescription)
                completion(false, apiError)
                return
            }
            
            token.prepareExpirationDateIfNeed()
            oauthToken = token
            logToken()
            
            completion(true, nil)
        }
    }
    
    static var isLoggedIn: Bool {
        logToken()
        return oauthToken?.isValidExpirationDate ?? false
    }
    
    static func removeToken() {
        oauthToken = nil
    }
    
    static func logoutRoot() {
        removeToken()
        //Router.showRunTimeLoginIfNeed()
    }
    
    static func logoutPresent() {
        removeToken()
        //Router.presentOnlineLoginController()
    }

    static func updateAppPresent() {
        //Router.presentUpdateAppController()
    }
    
    private static func logToken() {
        #if DEBUG
        guard let accessToken = accessToken else {
            return
        }
        //DispatchQueue.once {
            print("access token = \(accessToken)")
        //}
        #endif
    }
}

extension AuthManager {
    static var readWrite: Bool {
        guard let userRole = userRole else {
            return false
        }
        return userRole == "READWRITE"
    }
    
    static var readOnly: Bool {
        guard let userRole = userRole else {
            return true
        }
        return userRole == "READONLY"
    }
    
    static var userRole: String? {
        return oauthToken?.userRole
    }
}
