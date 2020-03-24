//
//  AppDelegate.swift
//  wrf
//
//  Created by Rinat on 09/11/2018.
//  Copyright © 2018 Gstudio. All rights reserved.
//

import UIKit
import Foundation

typealias AlertLoaderPresentable = AlertPresentable & LoaderPresentable

protocol LoaderPresentable: class {
    func setLoading(_ loading: Bool)
}

protocol AlertPresentable: class {
    func present(error: Error)
}

protocol ViewInteractionSettable {
    func setInteraction(isEnable: Bool)
}

extension UIViewController: LoaderPresentable {
    
    private enum AssociatedKeys {
        static var indicatorKey: Int = 0
    }
    
    private var indicator: ActivityIndicatorView {
        get {
            guard let value = objc_getAssociatedObject(self,
                                                       &AssociatedKeys.indicatorKey) as? ActivityIndicatorView
                else {
                    let indicator = ActivityIndicatorView()
                    self.indicator = indicator
                    return indicator
            }
            return value
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.indicatorKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setLoading(_ loading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if loading {
                self?.indicator.showLoader()
            } else {
                self?.indicator.hideLoader()
            }
        }
    }
}

extension UIViewController: ViewInteractionSettable {
    func setInteraction(isEnable: Bool) {
        view.isUserInteractionEnabled = isEnable
    }
}
