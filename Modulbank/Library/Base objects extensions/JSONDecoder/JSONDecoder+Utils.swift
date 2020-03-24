//
//  JSONDecoder.swift
//  MPM
//
//  Created by Артем Кулагин on 24.09.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func decodeDictionary<T>(_ type: T.Type, from dict: [String: Any]?) -> T? where T: Decodable {
        guard let dict = dict,
            let data = dict.jsonStringData else {
                return nil
        }
        var item: T?
        let decoder = JSONDecoder()
        do {
            item = try decoder.decode(T.self, from: data)
        } catch {
            print("error", error)
        }
        return item
    }
    
    func decodeDictionarys<T>(_ type: T.Type, from dicts: [[String: Any]]?) -> [T]? where T: Decodable {
        return dicts?.compactMap({
            decodeDictionary(type, from: $0)
        })
    }
    
    func decodeDictionarys<T>(_ type: T.Type, from parsed: Any?, rootKey: String?) -> [T]? where T: Decodable {
        guard let key = rootKey,
            let rawModels = (parsed as? [String: Any])?[key] as? [[String: Any]] else {
            return nil
        }
        return JSONDecoder().decodeDictionarys(type, from: rawModels)
    }
}
