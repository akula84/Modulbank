//
//  UITableView+Registration.swift
//  MPM
//
//  Created by Alexander on 30.08.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit


extension UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}


extension UITableView {
    func registerNib<C: UITableViewCell>(for class: C.Type, identifier: String? = nil) {
        let id = identifier ?? String(describing: C.self)
        register(C.nib, forCellReuseIdentifier: id)
    }
    
    func registerHeaderFooter<V: UITableViewHeaderFooterView>(for class: V.Type, identifier: String? = nil) {
        let className = String(describing: V.self)
        let nib = UINib(nibName: className, bundle: nil)
        let id = identifier ?? className
        register(nib, forHeaderFooterViewReuseIdentifier: id)
    }
    
    func registerIdentifier(_ reuseID: String) {
        let nib = UINib(nibName: reuseID, bundle: nil)
        register(nib, forCellReuseIdentifier: reuseID)
    }
    
    func dequeue<C: UITableViewCell>(for indexPath: IndexPath, identifier: String? = nil) -> C {
        let id = identifier ?? String(describing: C.self)
        let cell = dequeueReusableCell(withIdentifier: id, for: indexPath)
        guard let rightClassCell = cell as? C else {
            fatalError("Expected to dequeue cell of class \(C.self) for index path \(indexPath) with identifier \(id) but got \(cell)")
        }
        return rightClassCell
    }
}
