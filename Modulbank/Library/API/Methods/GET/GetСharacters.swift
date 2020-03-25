//
//  GetDealDocTypes.swift
//  MPM
//
//  Created by Артем Кулагин on 11/10/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit

class GetСharacters: AlamofireAPI {
    override var path: String {
        return "/character"
    }

    override func apiDidReturnReply(_ parsed: Any?, raw: Any?) {
        let rawModels = (parsed as? AliasDictionary)?["results"] as? [AliasDictionary]
        let items = JSONDecoder().decodeDictionarys(CharacterItem.self, from: rawModels)
        DispatchQueue.main.async {
            super.apiDidReturnReply(items, raw: raw)
        }
    }
}
