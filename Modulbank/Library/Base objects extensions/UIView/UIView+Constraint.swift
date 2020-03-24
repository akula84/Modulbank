//
//  UIView+Constraint.swift
//  MPM
//
//  Created by Артем Кулагин on 22/10/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraint(height: CGFloat?) {
        guard let height = height  else {
            return
        }
        addConstraint(NSLayoutConstraint(item: self,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: height))
    }
    
    func addConstraint(width: CGFloat?) {
        guard let width = width  else {
            return
        }
        addConstraint(NSLayoutConstraint(item: self,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: width))
    }
}
