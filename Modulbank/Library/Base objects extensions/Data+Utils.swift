//
//  Data+Utils.swift
//  Spytricks
//
//  Created by Артем Кулагин on 26.05.17.
//  Copyright © 2017 Ivan Alekseev. All rights reserved.
//

import Foundation

extension Data {
    
    func jsonObject(options opt: JSONSerialization.ReadingOptions = []) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Any]
        } catch {
            return nil
        }
    }
    
    var bookmarkUrl: URL? {
        var value: URL?
        do {
            var stale = false
            value = try URL(resolvingBookmarkData: self, bookmarkDataIsStale: &stale)
        } catch {
            print("bookmarkUrl error", error)
        }
        return value
    }
    
    public func hexEncodedString() -> String {
        let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }
        return String(self.reduce(into: "".unicodeScalars, { (result, value) in
            result.append(hexAlphabet[Int(value/16)])
            result.append(hexAlphabet[Int(value%16)])
        }))
    }
}
