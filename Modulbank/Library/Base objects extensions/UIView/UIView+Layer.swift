//
//  UIView+Layer.swift
//  Spytricks
//
//  Created by Артем Кулагин on 16.05.17.
//  Copyright © 2017 Ivan Alekseev. All rights reserved.
//

import UIKit


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return 0 }
        set {
            self.layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return 0 }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return .clear }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
}
