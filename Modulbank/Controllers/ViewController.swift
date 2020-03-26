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

    lazy var scrollingPaginator: ScrollingPaginator<Adapter>? = {
        let api = API()
        let adapter = Adapter(api: api)
        var paginator = ScrollingPaginator(provider: adapter)
        var firstLoad = true
        paginator.onLoadingStarted = { _ in
            if firstLoad {
                firstLoad = false
                Router.showLoader()
            }
        }
        paginator.onItemsLoaded = { [weak self] result in
            Router.removeLoader()
            switch result {
            case .failure: MessageCenter.showMessage(L10n.popupErrorClientMessageLoadingMessage)
            case .success:
                self?.tableView.reloadData()
            }
        }
        return paginator
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollingPaginator?.start()
    }
}
