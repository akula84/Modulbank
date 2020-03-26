//
//  ScrollingPaginator.swift
//  MPM
//
//  Created by Alexander on 23.08.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit
import Alamofire

/** Класс для постраничной загрузки элементов */
final class ScrollingPaginator<P: PaginatedItemsProvider> {
    let provider: P
    var lastVisibleIndex: Int {
        get {
            return _lastVisibleIndex
        }
        set {
            _lastVisibleIndex = newValue
            loadNewItemsIfNecessary()
        }
    }
    
    var isRequestInProgress: Bool {
        return cancellable != nil
    }
    
    var onLoadingStarted: (Pagination) -> Void = { _ in }
    var onItemsLoaded: (Result<Range<Int>>) -> Void = { _ in }
    
    private var _lastVisibleIndex: Int = 0
    private(set) var numberOfItems: Int = 0
    private(set) var reachedLimit: Bool = false
    
    private var lastPagination: Pagination?
    private var cache: [Int: P.Item] = [:]
    private let pageSize = 20
    private let margin = 5
    private var cancellable: Cancellable?
    private(set) var wasStarted = false
    
    init(provider: P) {
        self.provider = provider
    }
    
    func cancelLoading() {
        cancellable?.cancel()
        cancellable = nil
    }
    
    subscript (index: Int) -> P.Item? {
        return cache[index]
    }
    
    func increaseLastVisibleIndex(to newIndex: Int) {
        if newIndex > lastVisibleIndex {
            lastVisibleIndex = newIndex
        } else if newIndex > numberOfItems - margin - 1 {
            loadNewItemsIfNecessary()
        }
    }
    
    func start() {
        wasStarted = true
        loadNewItemsIfNecessary()
    }
    
    func reset() {
        reachedLimit = false
        cancellable?.cancel()
        cancellable = nil
        cache = [:]
        lastPagination = nil
        numberOfItems = 0
        _lastVisibleIndex = 0
        wasStarted = false
    }
    
    // swiftlint:disable:next cyclomatic_complexity
    private func loadNewItemsIfNecessary() {
        if !wasStarted { return }
        if cancellable != nil { return }
        if reachedLimit { return }
        
        var paginationToLoad: Pagination?
        if let lastPagination = self.lastPagination {
            if numberOfItems - lastVisibleIndex < margin {
                paginationToLoad = lastPagination.nextPage()
            }
        } else {
            paginationToLoad = Pagination(pageSize: pageSize)
        }
        
        guard let pagination = paginationToLoad else { return }
        onLoadingStarted(pagination)
        cancellable = provider.provideItems(for: pagination, completionQueue: .global(qos: .userInteractive)) { [weak self](result) in
            guard let strongSelf = self else { return }
            self?.cancellable = nil
            var callbackResult: Result<Range<Int>>
            defer {
                DispatchQueue.main.async {
                    strongSelf.onItemsLoaded(callbackResult)
                    strongSelf.cancellable = nil
                    callbackResult.ifSuccess {
                        strongSelf.loadNewItemsIfNecessary()
                    }
                }
            }
            switch result {
            case .success(let items):
                for (index, item) in items.enumerated() {
                    strongSelf.cache[index + pagination.startItemIndex] = item
                }
                let realLoadedRange: Range<Int> = pagination.startItemIndex..<(pagination.startItemIndex + items.count)
                strongSelf.numberOfItems = realLoadedRange.upperBound
                if realLoadedRange.length == pagination.pageSize {
                    strongSelf.lastPagination = pagination
                } else {
                    strongSelf.reachedLimit = true
                }
                callbackResult = .success(realLoadedRange)
            case .failure(let error):
                callbackResult = .failure(error)
            }
        }
    }
    
    deinit {
        cancelLoading()
    }
}
