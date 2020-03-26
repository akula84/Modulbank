//
//  Pagination.swift
//  MPM
//
//  Created by Alexander on 23.08.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation


struct Pagination {
    let pageIndex: Int // 0-based
    let pageSize: Int
    
    var range: CountableRange<Int> {
        return startItemIndex..<endItemIndex
    }
    
    var startItemIndex: Int { // 0-based
        return pageSize * pageIndex
    }
    
    var endItemIndex: Int {
        return pageSize * (pageIndex + 1) - 1
    }
    
    init(pageIndex: Int = 0, pageSize: Int) {
        precondition(pageIndex >= 0, "pageIndex can't be negative")
        precondition(pageSize > 0, "pageSize must be > 0")
        self.pageIndex = pageIndex
        self.pageSize = pageSize
    }
    
    func nextPage() -> Pagination {
        return Pagination(pageIndex: pageIndex + 1, pageSize: pageSize)
    }
    
    static func minimumPaginationToCover(range: CountableClosedRange<Int>) -> Pagination {
        let rangeLength = range.upperBound - range.lowerBound + 1
        for size in rangeLength...(range.upperBound + 1) {
            let lowerNumberOfPages = range.lowerBound / size
            if (lowerNumberOfPages + 1) * size > range.upperBound {
                return Pagination(pageIndex: lowerNumberOfPages, pageSize: size)
            }
        }
        return Pagination(pageIndex: 0, pageSize: range.upperBound + 1) // этого не должно произойти, но на всякий случай
    }
}


extension Pagination: CustomStringConvertible {
    var description: String {
        return "[Page \(pageIndex) of size \(pageSize)]"
    }
}
