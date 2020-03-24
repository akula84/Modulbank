//
//  API+ReplyHandling.swift
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

import Foundation

extension API {
    /// Handles successful request
    ///
    /// - Parameters:
    ///   - parsed: parsed reply that should be returned
    ///   - raw: raw reply from API request
    @objc
    func apiDidReturnReply(_ parsed: Any?, raw: Any?) {
        //APIlog("API \(self) did return reply: \(String(describing: parsed))")

        lastReply = parsed
        lastError = nil

        var shouldUseDefaultErrorHandler = true

        if let completion = self.completion {
            completion(parsed, nil, &shouldUseDefaultErrorHandler)
        }

        apiDidEnd()
    }


    /// Handles failed request
    ///
    /// - Parameter error: reason of request failure
    func apiDidFailWithError(_ error: Error) {
        APIlog("API \(self) did fail with error: \(error)")

        lastReply = nil
        lastError = error

        var shouldUseDefaultErrorHandler = true

        if let completion = self.completion {
            completion(nil, error, &shouldUseDefaultErrorHandler)
        }

        if shouldUseDefaultErrorHandler {
            showError(error)
        }

        apiDidEnd()
    }
    
    @objc 
    func showError(_ error: Error?) {
        DispatchQueue.main.async {
            MessageCenter.showError(error)
        }
    }

    /// Handles all request ends (successful and failed)
    @objc
    func apiDidEnd() {
        syncSemaphore?.signal()
    }
}
