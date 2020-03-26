//
//  APICancellable.swift
//  MPM
//
//  Created by Alexander on 23.08.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation
import Alamofire


struct APICancellable: Cancellable {
    var api: API?
    
    init(api: API) {
        self.api = api
    }
    
    func cancel() {
        api?.cancel()
    }
}
