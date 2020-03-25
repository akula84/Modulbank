//
//  UITableView+Utils.swift
//  C-way
//
//  Created by Sergey Lyubeznov on 25/07/16.
//  Copyright © 2016 El-Machine. All rights reserved.
//

import UIKit


extension UITableView {
    
    func hideEmptyCells() {
        tableFooterView = UIView(frame: CGRect.zero)
    }
    
    var tableViewContentSize: CGFloat {
        var height: CGFloat = 0
        let numberOfRowsInSection = self.numberOfRows(inSection: 0)
        if numberOfRowsInSection > 0 {
            for i in 0...numberOfRowsInSection - 1 {
                let rect = self.rectForRow(at: IndexPath(row: i, section: 0))
                height += rect.height
            }
        }
        return height
    }
    
    @IBInspectable var topInset: CGFloat {
        get { return 0 }
        set {
            contentInset = UIEdgeInsets(top: newValue, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right)
        }
    }
    
    @IBInspectable var bottomInset: CGFloat {
        get { return 0 }
        set {
            contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: newValue, right: contentInset.right)
        }
    }
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
