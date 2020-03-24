//
//  PutAPI.swift
//  Trucker
//
//  Created by Alex Kozin on 17.01.2018.
//  Copyright © 2018 el-machine. All rights reserved.
//

import Alamofire

class PutAPI: PostAPI {

    override var method: HTTPMethod {
        return .put
    }

}
