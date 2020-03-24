//
//  NSError+Error.swift
//  MPM
//
//  Created by Артем Кулагин on 06.09.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension NSError {
    
    static var codeCancel: Int {
        return -999
    }
    
    var isCancel: Bool {
        return code == NSError.codeCancel
    }
    
    var userInfoMessage: String? {
        return userInfo[NSError.keyMessage] as? String
    }
    
    static var keyMessage: String {
        return "message"
    }
    
    var isLastPageError: Bool {
        return self == APIUtils.Errors.lastPageError
    }
    
    static var domainBell: String {
        return Bundle.main.bundleIdentifier ?? "com.bellintegrator.api"
    }
    
    static func error500(_ message: String) -> NSError {
        return NSError(domain: domainBell, code: 500, userInfo: [NSError.keyMessage: message])
    }
    
    static func error401(error: String, message: String) -> NSError {
       return errorBell(code: 401, error: error, message: message)
    }
    
    static func error999(error: String? = nil, message: String? = nil) -> NSError {
        return errorBell(code: 999, error: error, message: message)
    }
    
    static func errorBell(code: Int, error: String? = nil, message: String? = nil) -> NSError {
        return NSError(domain: domainBell,
                       code: code ,
                       userInfo: ["error": error ?? "", NSError.keyMessage: message ?? ""])
    }
    
    static var internalError: NSError {
        return NSError.error500(L10n.internalError)
    }
}

extension Error {
    
    var nsError: NSError {
        return self as NSError
    }
    
    var isCancel: Bool {
        return nsError.isCancel
    }
    
    var isLastPageError: Bool {
        return nsError.isLastPageError
    }
    
    static var internalError: Error {
        return NSError.internalError
    }
    
    var messageForError: String {
        return (nsError.userInfo["message"] as? String) ?? localizedDescription
    }
}
