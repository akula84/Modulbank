//
//  Cancellable.swift
//  MPM
//
//  Created by Alexander on 10.09.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation


protocol Cancellable {
    func cancel()
}


struct EmptyCancellable: Cancellable {
    func cancel() {}
}
