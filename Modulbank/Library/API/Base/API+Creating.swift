//
//  API+Creating.swift
//
// Created by Alexander Kozin https://github.com/alkozin
// Copyright (c) 2016 http://el-machine.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

extension API {
    /// Creates api instance and send request
    ///
    /// - Parameters:
    ///   - sync: <#sync description#>
    ///   - object: Object for generating a request
    ///   - completion: A block that invokes after request is finished
    @discardableResult
    convenience init(sync: Bool = false, object: Any? = nil, completion: APICompletion? = nil) {
        self.init()

        self.object = object
        if completion != nil {
            sendRequestWithCompletion(sync: sync, completion)
        }
    }
    
    @discardableResult
    convenience init(sync: Bool = false, object: Any? = nil, dictCompletion: APIDictCompletion? = nil) {
        self.init(sync: sync, object: object) { (reply, error, handle) in
            dictCompletion?(reply as? [String: Any], error, &handle)
        }
    }
    
}
