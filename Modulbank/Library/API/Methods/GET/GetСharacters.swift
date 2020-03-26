//
//  GetDealDocTypes.swift
//  MPM
//
//  Created by Артем Кулагин on 11/10/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit
import Alamofire

class GetСharacters: AlamofireParamsPagedAPI, ItemsArrayProviderAPI {
    
    typealias APIItem = CharacterItem
    
    override var path: String {
        return "/character"
    }

    override func apiDidReturnReply(_ parsed: Any?, raw: Any?) {
        let rawModels = (parsed as? AliasDictionary)?["results"] as? [AliasDictionary]
        let items = JSONDecoder().decodeDictionarys(APIItem.self, from: rawModels)
        DispatchQueue.main.async {
            super.apiDidReturnReply(items, raw: raw)
        }
    }
    
    override var shouldLogRequest: Bool {
        true
    }
}
