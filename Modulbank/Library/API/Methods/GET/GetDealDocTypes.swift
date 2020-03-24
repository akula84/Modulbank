//
//  GetDealDocTypes.swift
//  MPM
//
//  Created by Артем Кулагин on 11/10/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit

class GetDealDocTypes: AlamofireAPI {
    
    override var path: String {
        return "/api/bw/getdealdoctypes"
    }
    
    override func showError(_ error: Error?) {}
    /*
    override func apiDidReturnReply(_ parsed: Any?, raw: Any?) {
        guard let dicts = (parsed as? [String: Any])?["dealDocType"] as? [[String: Any]] else {
            return
        }
        let items = JSONDecoder().decodeDictionarys(DealDocType.self, from: dicts)
        DispatchQueue.main.async {
            super.apiDidReturnReply(items, raw: raw)
        }
    }
     */
    
    override func apiDidReturnReply(_ parsed: Any?, raw: Any?) {
        guard let dicts = (parsed as? [String: Any])?["dealDocType"] as? [[String: Any]] else {
            return
        }
        DispatchQueue.main.async {
            super.apiDidReturnReply(dicts, raw: raw)
        }
    }
}
