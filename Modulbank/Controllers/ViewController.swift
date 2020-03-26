//
//  ViewController.swift
//  Modulbank
//
//  Created by Артем Кулагин on 25.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    typealias API = GetСharacters
    typealias Adapter = ScrollingPaginatorAlamofireAdapter<API>
    var scrollingPaginator: ScrollingPaginator<Adapter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollingPaginator()
    }
    
    func setupScrollingPaginator() {
        let api = API()
        let adapter = Adapter(api: api)
        scrollingPaginator = ScrollingPaginator(provider: adapter)
        var firstLoad = true
        scrollingPaginator?.onLoadingStarted = { _ in
            if firstLoad {
                firstLoad = false
                Router.showLoader()
            }
        }
        
        scrollingPaginator?.onItemsLoaded = { [weak self] result in
            Router.removeLoader()
            switch result {
            case .failure: MessageCenter.showMessage(L10n.popupErrorClientMessageLoadingMessage)
            case .success:
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollingPaginator?.start()
    }
}
