//
//  RNSDataManager.swift
//  RNIS
//
//  Created by Артем Кулагин on 07.08.17.
//  Copyright © 2017 Артем Кулагин. All rights reserved.
//

import UIKit
import RealmSwift
/**
 Контроллер БД
 */
class RNSDataManager: NSObject {
    
    /// переменная синглетона
    static let shared = RNSDataManager()
    
    static var realm: Realm? {
        do {
           return try Realm()
        } catch {
            return nil
        }
    }
    
    static func objects<T>(_ type: T.Type) -> Results<T>? {
        guard let result = realm?.objects(type as! Object.Type) as? Results<T> else {
            return nil
        }
        return result
    }
    
    static func write(_ block: EmptyBlock?, complete: EmptyBlock? = nil) {
        do {
            try realm?.write {
                block?()
            }
            complete?()
        } catch {}
    }
    
    static func parseDataBuss(_ dicts: [AliasDictionary]) -> [DealDocTypeBase] {
        var items = [DealDocTypeBase]()
        write ({
            //CounterTime.startTimer()
            for dict in dicts {
                guard let item = realm?.create(DealDocTypeBase.self, value: dict, update: .all) else {
                    continue
                }
                items.append(item)
            }
             //CounterTime.endTimer()
            
        })
        return items
    }
    
    static var items: Results<DealDocTypeBase>? {
        return realm?.objects(DealDocTypeBase.self)
    }
}
