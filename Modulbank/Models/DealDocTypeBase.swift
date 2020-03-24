//
//  DealDocTypeBase.swift
//  Modulbank
//
//  Created by Артем Кулагин on 24.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import RealmSwift

class DealDocTypeBase: Object {
    @objc dynamic var docId: Int = 0
    @objc dynamic var docName: String = ""
    
    override static func primaryKey() -> String? {
        return "docId"
    }
} 
