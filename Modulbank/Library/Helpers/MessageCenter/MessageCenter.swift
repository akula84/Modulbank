//
//  MessageCenter.swift
//  Day
//
//  Created by Alexander Kozin on 02.06.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import UIKit

class MessageCenter: NSObject {
    /// Enables test mode for showing all real errors
    static let showTestRealErrorsToUser = true

    /// Shows message view to user
    ///
    /// - Parameter message: Message text
    static func showMessage(_ message: String?, handler: (() -> Void)? = nil) {
        guard let message = message else {
            return
        }
        if !message.isEmpty {
            showAlertView(withTitle: nil, andMessage: message, handler: handler)
        }
    }
    
    static func showPermissionError() {
        MessageCenter.showMessage(L10n.permissionError)
    }
    

    /// Shows error message to user if 'error' exist
    /// Calls showErrorIfExist:error:otherwisePerform: internally
    ///
    /// - Parameter error: Error object for generating a message
    static func showError(_ error: Error?) {
        showErrorIfExist(error, otherwisePerform: nil)
    }

    /// Shows error message to user if 'error' exist, otherwise invoke 'block'
    /// Calls +showErrorIfExist:error:otherwisePerform: internally
    ///
    /// - Parameters:
    ///   - error: Error object for generating a message
    ///   - block: Handler if error is nil
    static func showErrorIfExist(_ error: Error?, otherwisePerform block: (() -> Void)?) {
        showErrorIfExist(error, errorBlock: nil, otherwisePerform: block)
    }

    /// Shows error message to user if 'error' exist and invoke 'errorBlock', otherwise invoke 'block'
    ///
    /// - Parameters:
    ///   - error: Error object for generating a message
    ///   - errorBlock: Handler if error is exist
    ///   - block: Handler if error is nil
    static func showErrorIfExist(_ error: Error?, errorBlock:  (() -> Void)?, otherwisePerform block: (() -> Void)?) {
        if let error = error {
            if shouldShowRealErrorToUser(error as NSError) {
                showRealErrorAlertView(error)
            } else {
                showHostNotReachableError()
            }

            if let errorBlock = errorBlock {
                errorBlock()
            }
        } else if let block = block {
            block()
        }
    }

    static func showHostNotReachableError() {
        showAlertView(withTitle: localizedString("common.hostNotReachable.title"),
                      andMessage: localizedString("common.hostNotReachable.message"))
    }

    static func showAlertView(withTitle title: String?, andMessage message: String, handler: (() -> Void)? = nil) {
        let controller = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
        controller.addActionCancel(title: L10n.Common.ok, handler: { _ in
            handler?()
        })

        dispatchMainSyncSafe {
            Router.present(controller)
        }
    }

    static func showRealErrorAlertView(_ error: Error?) {
        if let message = error?.messageForError {
            showAlertView(withTitle: nil, andMessage: message)
        }
    }

    static func shouldShowRealErrorToUser(_ error: NSError) -> Bool {
        if showTestRealErrorsToUser {
            return true
        }

        return error.code == 300
    }

    private static func dispatchMainSyncSafe(_ block:  () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync(execute: block)
        }
    }
    
    static func showAlertOkCancel(_ text: String? = L10n.error,
                                  title: String? = L10n.message,
                                  titleOk: String? = L10n.Common.ok,
                                  completeOk: (() -> Void)? = nil,
                                  titleCancel: String? = L10n.cancel,
                                  completeCancel: (() -> Void)? = nil,
                                  preferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: preferredStyle)
        alert.addActionWith(title: titleOk, style: .default, handler: { _ in
            completeOk?()
        })
        alert.addActionWith(title: titleCancel, style: .cancel, handler: { _ in
            completeCancel?()
        })
        present(alert)
    }
    
    static func showActionSaveForm(yesComplete: EmptyBlock? = nil,
                                   noComplete: EmptyBlock? = nil) {
        showYesNoCancel(message: L10n.actionSaveForm, yesComplete: yesComplete, noComplete: noComplete)
    }
    
    static func showYesNoCancel(message: String, yesComplete: EmptyBlock? = nil,
                                noComplete: EmptyBlock? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: L10n.yes, style: .destructive) { _ in
            yesComplete?()
        }
        let noAction = UIAlertAction(title: L10n.no, style: .default) {  _ in
            noComplete?()
        }
        let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel) { _ in
            alert.dismiss()
        }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        alert.addAction(cancelAction)
        Router.present(alert, animated: false)
    }
    
    static func showMessageYouSureExit(completeOk:(() -> Void)?) {
        MessageCenter.showAlertOkCancel(L10n.bottomMenuAreYouSure, titleOk: L10n.yes, completeOk: completeOk, titleCancel: L10n.no)
    }

    static func present(_ viewControllerToPresent: UIViewController?, animated: Bool = true, completion: (() -> Void)? = nil) {
        dispatchMainSyncSafe {
            Router.present(viewControllerToPresent, animated: animated, completion: completion)
        }
    }

    private static func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
