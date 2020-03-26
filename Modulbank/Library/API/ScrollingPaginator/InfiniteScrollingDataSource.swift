//
//  InfiniteScrollingDataSource.swift
//  Modulbank
//
//  Created by Артем Кулагин on 26.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import Foundation

import Alamofire
import UIKit

class InfiniteScrollingDataSource<Provider: PaginatedItemsProvider> {
    let provider: Provider
    let scrollingPaginator: ScrollingPaginator<Provider>
    var items: [Provider.Item] = []

    init(tableView: UITableView, provider: Provider) {
        self.provider = provider
        scrollingPaginator = ScrollingPaginator(provider: provider)
        scrollingPaginator.onLoadingStarted = { [unowned self] pagination in
            // NotificationCenter.default.post(name: LoadingNotificationName.started, object: self.tableView)
            self.onLoadingStarted(pagination)
        }
        scrollingPaginator.onItemsLoaded = { [unowned self] result in
            // NotificationCenter.default.post(name: LoadingNotificationName.ended, object: self.tableView)
            result.ifSuccess {
                self.items = (0 ..< self.scrollingPaginator.numberOfItems).map { self.scrollingPaginator[$0]! }
            }
            self.onItemsLoaded(result)
        }
    }

    var onLoadingStarted: (Pagination) -> Void = { _ in }
    var onItemsLoaded: (Result<Range<Int>>) -> Void = { _ in }

    func start() {
        scrollingPaginator.start()
    }

    func cancelLoading() {
        scrollingPaginator.cancelLoading()
    }

    func increaseLastVisibleIndex(to indexPath: IndexPath) {
        scrollingPaginator.increaseLastVisibleIndex(to: indexPath.row)
    }
}
