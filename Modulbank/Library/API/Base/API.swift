//
//  API.swift
//
// Created by El Machine
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

import Foundation
import Alamofire

public typealias APICompletion = (_ reply: Any?, _ error: Error?, _ handleError: inout Bool) -> Void
public typealias APIDictCompletion = (_ reply: [String: Any]?, _ error: Error?, _ handleError: inout Bool) -> Void
public typealias APIProgress = (_ progress: Double) -> Void

protocol APIInterface {

    var completion: APICompletion? {get set}
    var isRequestInProgress: Bool {get}

    func sendRequestWithCompletion(_ completion: APICompletion?)

    func apiDidReturnReply(_ parsed: Any?, raw: Any?)
    func apiDidFailWithError(_ error: Error)
    func apiDidEnd()

    func APIlog(_ message: String)

    func cancel()

}

open class API: NSObject, APIInterface {
    /// Api object to generate request
    var object: Any?

    /// Returns parameters for API request
    var parameters: [String: Any] {
        let parameters = [String: Any]()

        //WARNING: This is a point to add any common data to all requests
        // E.g.access token
        //if (self.shouldAddAccessToken) {
        //    parameters["private_token"] = "inZfe4ogw91KZSY4U1Gy"
        //}

        return parameters
    }
    
    /// Headers for API request
    var headers: [String: Any] {
        let headers = [String: Any]()
        return headers
    }

    var timeout: TimeInterval {
        return 60.0
    }

    /// Last API reply
    var lastReply: Any?

    /// Last API error
    var lastError: Error?

    /// Request completion handler
    var completion: APICompletion?

    /// Returns true if API request is already sent and not complete
    var isRequestInProgress: Bool {
        preconditionFailure("Concrete API object should override progress indicator like 'return alamofireRequest != nil'")
    }

    var shouldLogRequest: Bool {
        return false
    }

    /// Semaphore for sync requests
    var syncSemaphore: DispatchSemaphore?

    /// Creates api instance
    override init() {
        super.init()
        prepare()
    }

    /// Presets default settings to API object
    func prepare() {
        // E.g. add access token to request or log level
    }

    /// Sends api request with completion
    ///
    /// - Parameters:
    ///   - sync: Determine whether request should be sent synchromiously
    ///   - completion: A block that invokes after request is finished
    func sendRequestWithCompletion(sync: Bool, _ completion: APICompletion?) {
        sendRequestWithCompletion(completion)

        if sync {
            syncSemaphore = DispatchSemaphore(value: 0)
            _ = syncSemaphore!.wait(timeout: DispatchTime.now() + timeout)
        }
    }

    func sendRequestWithCompletion(_ completion: APICompletion?) {
        self.completion = completion
    }

    func newParser() -> APIParser {
        return Parser()
    }

    func APIlog(_ message: String) {
        if shouldLogRequest {
            print(message)
        }
    }

    /// Parses successfull reply
    ///
    /// - Parameter reply: raw reply from back end
    func requestDidReturnRawReply(_ reply: Any?) {
        var parsedReply = reply
        if let classForParsingReply = classForParsingReply {
            parsedReply = newParser().parsed(reply, to: classForParsingReply)
        }
        if shouldLogRequest {
            print("requestDidReturnRawReply", reply ?? "")
        }
        apiDidReturnReply(parsedReply, raw: reply)
    }
    
    func requestDidReturnDataReply(_ reply: DataResponse<Data>) {
        if shouldLogRequest {
            print("requestDidReturnDataReply", reply)
        }
        apiDidReturnReply(reply, raw: nil)
    }

    override open var description: String {
        return String("\(super.description) object: \(String(describing: object))")
    }

}
