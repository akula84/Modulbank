//
//  APIUtils.swift
//  BaseApp
//
//  Created by Alexander Kozin on 21.11.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Foundation

// Utils
struct APIUtils {

    struct Errors {
        static let lastPageError = NSError(domain: "com.el-machine.api",
                                           code: 204,
                                           userInfo: ["message": "There is no more content"])
    }

    static let executableName = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String ?? ""

    static func swiftClassFromString(_ className: String) -> AnyClass? {
        return NSClassFromString(executableName + "." + className)
    }

    static func stringFromSwiftClass(_ swiftClass: AnyClass) -> String {
        return NSStringFromClass(swiftClass).components(separatedBy: ".").last!
    }

}

extension Dictionary {

    public mutating func append(_ newElement: [Key: Value]) {
        newElement.forEach { body in
            updateValue(body.1, forKey: body.0)
        }
    }

    public mutating func append(_ optionalElement: [Key: Value]?) {
        guard let element = optionalElement else {
            return
        }

        append(element)
    }

}
