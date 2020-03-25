//
//  RNSRegisterTableView.swift
//
//  Created by Артем Кулагин on 11.08.17.
//  Copyright © 2017 Артем Кулагин. All rights reserved.
//

import UIKit
/**
 Класс базовый для таблицы
 */
class RegisterTableView: UITableView {
    /// Переменная содержащая строку идентификатора ячейки
    @IBInspectable var registerCellIdentifier: String {
        get { return "" }
        set {
            if !newValue.isEmpty {
                self.registerIdentifier(newValue)
            }
        }
    }
}
