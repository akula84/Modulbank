//
//  OauthToken.swift
//  BaseApp
//
//  Created by Alexander Tarasov on 26/06/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

class OauthToken: BaseModel {
    // Errors fields
    @objc var error: String?
    @objc var errorDescription: String?
    
    // Auth Token fields
    @objc var accessToken: String?
    @objc var tokenType: String?
    @objc var refreshToken: String?
    @objc var expiresIn: NSNumber?
    @objc var scope: String?
    @objc var userRole: String?
    @objc var expirationDate: Date?
    
    func prepareExpirationDateIfNeed() {
        if expirationDate == nil, let expiresIn = expiresIn?.intValue {
            expirationDate = Date(timeIntervalSinceNow: TimeInterval(expiresIn))
        }
    }
    
    var isValidExpirationDate: Bool {
        guard let expirationDate = expirationDate, expirationDate > Date()  else {
            return false
        }
        return true
    }
    
}
