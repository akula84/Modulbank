//
//  BaseViewWithXIBInit.swift
//
//  Created by Artem Kulagin on 31.08.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import UIKit

/**
 Базовый класс для инициализации UIView из xib
 */
class BaseViewWithXIBInit: UIView {
    
    /// Названия xib файла
    var nibNamed: String {
        return String(describing: type(of: self))
    }
    
    /// Метод инициализации класса
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibViewAtName()
    }
    
    /// Метод инициализации класса
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    /// Метод инициализации класса
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNibViewAtName()
    }
    
    /// Метод загрузки вью из xib
    func loadNibViewAtName() {
        insertNibView(nibNamed)
    }
}
