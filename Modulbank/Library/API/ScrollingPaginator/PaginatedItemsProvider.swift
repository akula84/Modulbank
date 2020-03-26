//
//  PaginatedItemsProvider.swift
//  MPM
//
//  Created by Alexander on 10.09.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Alamofire
import Foundation

protocol PaginatedItemsProvider: class {
    associatedtype Item

    var totalNumberOfItems: Int? { get }

    func provideItems(for pagination: Pagination, completionQueue: DispatchQueue, completion: @escaping (Result<[Item]>) -> Void) -> Cancellable
}

extension PaginatedItemsProvider {
    var totalNumberOfItems: Int? { return nil }
}

extension PaginatedItemsProvider {
    func provideItems(for range: CountableClosedRange<Int>, completionQueue: DispatchQueue, completion: @escaping (Result<[Item]>) -> Void) -> Cancellable {
        let rangeLength = range.upperBound - range.lowerBound + 1
        let pagination = Pagination.minimumPaginationToCover(range: range)
        let startMargin = max(range.lowerBound - pagination.startItemIndex, 0)

        return provideItems(for: pagination, completionQueue: completionQueue) { result in
            switch result {
            case .failure:
                completion(result)
            case let .success(items):
                let itemsMatchingRange = Array(items.dropFirst(startMargin).prefix(rangeLength))

                completion(.success(itemsMatchingRange))
            }
        }
    }
}
