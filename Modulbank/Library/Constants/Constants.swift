//
//  Constants.swift
//  Day
//
//  Created by Alexander Kozin on 25.03.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Foundation

typealias AliasDictionary = [String: Any]
typealias EmptyBlock = () -> Void

struct Constants {
    struct API {
        static let BaseURL =  "https://mwp.beeline.ru"
        static let BasicAuthHeader = "Basic dGVzdGp3dGNsaWVudGlkOlhZN2ttem9OemwxMDA="
        static let DefaultGrantType = "password"
    }

    struct ContentType {
        static let applicationJson = "application/json"
    }

    static var versionString: String {
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return String()
        }
        return versionNumber + "." + buildNumber
    }

    static var updateURL: URL? {
        return URL(string: "https://mwp.beeline.ru/ios/index.html")
    }
}
