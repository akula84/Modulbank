//
//  ItemsArrayProviderAPI.swift
//  MPM
//
//  Created by Alexander on 07.09.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation


protocol ItemsArrayProviderAPI: APIInterface {
    associatedtype APIItem
    func parse(reply: Any) throws -> [APIItem]
}


extension ItemsArrayProviderAPI {
    func parse(reply: Any) throws -> [APIItem] {
        guard let items = reply as? [APIItem] else { throw ParsingError.parsingFailed }
        return items
    }
}


enum ParsingError: Error {
    case parsingFailed
}



