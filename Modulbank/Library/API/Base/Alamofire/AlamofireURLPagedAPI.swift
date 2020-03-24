//
//  URLPagedAPI.swift
//  BaseApp
//
//  Created by Vitaliy Zhukov on 31.10.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Foundation

class AlamofireURLPagedAPI: AlamofireAPI, PagedAPI {
    var offset = 1
    
    let firstPageNumber = 1
    
    var isLastPage: Bool = false
    
    var lastRecord: Int?
    
    var isFirstPage: Bool {
        return offset == firstPageNumber
    }
    
    var objectsPerPage = 20
    
    func resetToFirstPage() {
        offset = firstPageNumber
        isLastPage = false
    }
    
    func constructPath(forPage page: Int) -> String {
        let endpoint: String = super.absolutePath.deleteSuffix("/")
        let pageNumber: Int  = page
        let pageSize: Int    = objectsPerPage
        
        return "\(endpoint)/pageSize/\(pageSize)/pageNumber/\(pageNumber)"
    }
    
    override var absolutePath: String {
        // e.g. /api/bw/clientcontracts/pageSize/20/pageNumber/0?clientId=47798
        return constructPath(forPage: offset)
    }
    
    override func apiDidReturnReply(_ parsed: Any?, raw: Any?) {
        let raw = raw as? [String: Any]
        lastRecord = raw?["lastRecord"] as? Int
        
        super.apiDidReturnReply(parsed, raw: raw)
        
        if let lastPage = raw?["lastPage"] as? Int {
            offset += 1
            isLastPage = offset >= lastPage
        }
    }
}
