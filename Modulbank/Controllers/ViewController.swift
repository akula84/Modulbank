//
//  ViewController.swift
//  Modulbank
//
//  Created by Артем Кулагин on 24.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var items: [CharacterItem]? {
        didSet {
            reloadTable()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }

    func loadItems() {
        Router.showLoader()
        GetСharacters(sync: false, object: nil) { [weak self] reply, _, _ in
            DispatchQueue.main.async {
                Router.removeLoader()
                self?.items = reply as? [CharacterItem]
            }
        }
    }

    func reloadTable() {
        tableView.reloadData()
    }
}
