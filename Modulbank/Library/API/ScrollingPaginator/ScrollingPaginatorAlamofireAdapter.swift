//
//  AlamofireParamsPagedAPIAdapter.swift
//  MPM
//
//  Created by Alexander on 30.08.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Alamofire
import UIKit

final class ScrollingPaginatorAlamofireAdapter<A: AlamofireAPI>: PaginatedItemsProvider
    where A: PagedAPI, A: ItemsArrayProviderAPI {
    private(set) var api: A

    init(api: A) {
        self.api = api
    }

    private(set) var totalNumberOfItems: Int?

    func provideItems(for pagination: Pagination, completionQueue: DispatchQueue, completion: @escaping (Result<[A.APIItem]>) -> Void) -> Cancellable {
        api.offset = pagination.pageIndex + 1
        api.objectsPerPage = pagination.pageSize
        totalNumberOfItems = nil
        api.sendRequestWithCompletion { [weak self] reply, error, handle in
            guard let `self` = self else { return }

            var result: Result<[Item]>
            self.totalNumberOfItems = self.api.lastRecord
            defer {
                completionQueue.async {
                    completion(result)
                }
            }
            if let error = error {
                result = .failure(error)
                if error.isLastPageError || error.isCancel {
                    handle = false
                }
                return
            }
            guard let reply = reply else {
                result = .success([])
                return
            }
            do {
                let items = try self.api.parse(reply: reply)
                result = .success(items)
            } catch let parsingError {
                result = .failure(parsingError)
            }
        }
        return APICancellable(api: api)
    }
}
