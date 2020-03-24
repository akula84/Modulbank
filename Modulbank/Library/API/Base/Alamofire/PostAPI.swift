//
//  PostAPI.swift
//  SwiftAPIWrapper
//
//  Created by Alexander Kozin on 26.03.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Alamofire

class PostAPI: AlamofireAPI {

    // Set higher timeout for post requests
    // Default is 10
    override var timeout: TimeInterval {
        return 60.0
    }

    override var method: Alamofire.HTTPMethod {
        return .post
    }

    var serializedObject: [String: Any]? {
        guard object is APIModel else {
            return nil
        }

        return nil// Serializer().object(model, forKeys: keys)
    }

    override var parameters: [String: Any] {
        var parameters = super.parameters
        parameters.append(serializedObject)

        APIlog("API will send object: \(parameters)")

        return parameters
    }

    var keys: [String] {
        return [String]()
    }

    override var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

}
