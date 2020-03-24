//
//  DeleteAPI.swift
//  MPM
//
//  Created by Артем Кулагин on 05/12/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Alamofire

class DeleteAPI: PostAPI {
    
    override var method: HTTPMethod {
        return .delete
    }
    
}
