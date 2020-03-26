//
//  ParamsPagedAPI.swift
//  BaseApp
//
//  Created by Vitaliy Zhukov on 28.10.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import UIKit

class AlamofireParamsPagedAPI: AlamofireAPI, PagedAPI {
    var offset = 1

    let firstPageNumber = 1
    let offsetParameterName = "currentPage"

    var isLastPage: Bool = false

    var lastRecord: Int?
    
    override var parameters: [String: Any] {
        var parameters = super.parameters
        
        parameters["page"] = offset
        //parameters[limitParameterName] = objectsPerPage

        return parameters
    }
    
    var isFirstPage: Bool {
        return offset == firstPageNumber
    }

    var objectsPerPage = 20
    
    func resetToFirstPage() {
        offset = firstPageNumber
        isLastPage = false
    }

    override func apiDidReturnReply(_ parsed: Any?, raw: Any?) {
        let raw = raw as? [String: Any]
        lastRecord = raw?["lastRecord"] as? Int

        super.apiDidReturnReply(parsed, raw: raw)

        offset += 1
        guard let lastPage = raw?["lastPage"] as? Int else {
            return
        }
        isLastPage = offset >= lastPage
    }

}
