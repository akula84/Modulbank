//
//  UIAlertController+Utils.swift
//  PickUpp
//
//  Created by Артем Кулагин on 07.06.2018.
//  Copyright © 2018 Ilya Inyushin. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func addActionWith(title: String?, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
    
    func addActionCancel(title: String? = L10n.cancel, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        addActionWith(title: title, style: .cancel, handler: handler)
    }
}
