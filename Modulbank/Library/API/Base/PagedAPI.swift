//
//  PagedAPI.swift
//  BaseApp
//
//  Created by Alexander Kozin on 17.11.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import UIKit

protocol PagedAPI: APIInterface {
    var offset: Int { get set }
    var isFirstPage: Bool { get }
    var isLastPage: Bool { get }

    var objectsPerPage: Int { get set }
    var limitParameterName: String { get }

    func resetToFirstPage()
    var lastRecord: Int? { get }
}

extension PagedAPI {

    var limitParameterName: String {
        return "pageSize"
    }

    func requestNextPage() {
        if !isRequestInProgress {
            if isLastPage {
                APIlog("\(self) reached last page")

                apiDidFailWithError(APIUtils.Errors.lastPageError)
                apiDidEnd()
            } else {
                sendRequestWithCompletion(completion)
            }
        }
    }

    func requestFromFirstPage() {
        cancel()
        resetToFirstPage()
        requestNextPage()
    }

//    func requestAllItems(completion: Result<) {
//        self.sendRequestWithCompletion { reply, error, handle in
//            guard let reply
//        }
//    }
}
