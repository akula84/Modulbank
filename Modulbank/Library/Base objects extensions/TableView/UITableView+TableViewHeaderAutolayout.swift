//
//  UITableView+TableViewHeaderAutolayout.swift
//  MPM
//
//  Created by Alexander on 28.08.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit


extension UITableView {
    /// Set table header view & add Auto layout.
    func setTableHeaderView(headerView: UIView?) {
        guard let headerView = headerView else {
            return
        }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set first.
        tableHeaderView = headerView
        
        // Then setup AutoLayout.
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: widthAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    /// Update header view's frame.
    func updateHeaderViewFrame() {
        guard let headerView = self.tableHeaderView else { return }
        
        // Update the size of the header based on its internal content.
        headerView.layoutIfNeeded()
        
        // ***Trigger table view to know that header should be updated.
        let header = self.tableHeaderView
        self.tableHeaderView = header
    }
}
