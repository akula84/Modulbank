//
//  MWPError.swift
//  MPM
//
//  Created by Vladimir on 22/08/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

class MWPError {
    static let mwpErrorNotification = "ShowErrorMessage"
    static let mwpErrorText = "errorText"
    static func raiseError (message: String) {
         NotificationCenter.default.post(name: Notification.Name(MWPError.mwpErrorNotification), object: nil, userInfo: [MWPError.mwpErrorText: message])
    }
}

class RunError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
