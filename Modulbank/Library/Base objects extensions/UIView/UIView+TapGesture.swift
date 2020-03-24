//
//  UIView+TapGesture.swift
//  Spytricks
//
//  Created by Артем Кулагин on 12.04.17.
//  Copyright © 2017 Ivan Alekseev. All rights reserved.
//

import UIKit

private var xoAssociationKey: UInt8 = 0
private var xoAssociationKey1: UInt8 = 1

extension UIView {
    
    var handlerActionTap: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? (() -> Void)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var tap: UITapGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey1) as? UITapGestureRecognizer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey1, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func removeDefaultTap() {
        guard let tap = tap else {return}
        removeGestureRecognizer(tap)
    }
    
    func tapGesture(handler: (() -> Void)?) {
        self.handlerActionTap = handler
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionTapGesture))
        addGestureRecognizer(tap)
        self.tap = tap
    }
    
    @objc func actionTapGesture() {
        self.handlerActionTap?()
    }
    
    func hideKeyboard() {
        endEditing(true)
    }
    
}
