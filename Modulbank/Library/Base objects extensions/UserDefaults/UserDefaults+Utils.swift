//
//  UserDefaults+Utils.swift
//  Spytricks
//
//  Created by Артем Кулагин on 10.02.17.
//  Copyright © 2017 Ivan Alekseev. All rights reserved.
//

import Foundation

/**
 Расширение для UserDefaults
 */
extension UserDefaults {
    
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}
