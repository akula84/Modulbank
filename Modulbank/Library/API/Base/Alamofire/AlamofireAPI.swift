//
//  AlamofireAPI.swift
//  SwiftAPIWrapper
//
//  Created by Alexander Kozin on 26.03.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Alamofire


class AlamofireAPI: API {
    required override init() {
        super.init()
    }

    /// Last reply headers
    var lastHeaders: [AnyHashable: Any]?

    /// API method path
    var baseURLString: String {
        return Constants.API.BaseURL
    }

    var path: String {
        preconditionFailure("Request path should be set, override path")
    }

    var absolutePath: String {
        return baseURLString.appending(path)
    }

    /// Request's HTTP method
    var method: Alamofire.HTTPMethod {
        return .get
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    weak var alamofireRequest: Alamofire.DataRequest?
    override var isRequestInProgress: Bool {
        return alamofireRequest != nil
    }

    class MyServerTrustPolicyManager: ServerTrustPolicyManager {
        override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
            return ServerTrustPolicy.disableEvaluation
        }
    }

    lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCredentialStorage = nil // Отключение отображения ошибки CredStore - performQuery - Error copying matching creds.  Error=-25300, query=........
        return SessionManager(configuration: configuration,
                              delegate: SessionDelegate(),
                              serverTrustPolicyManager: MyServerTrustPolicyManager(policies: [:]))
    }()

    override func sendRequestWithCompletion(_ completion: APICompletion?) {
        super.sendRequestWithCompletion(completion)

        alamofireRequest = sessionManager.request(encodedURLRequest())

        alamofireRequest!.responseData(queue: DispatchQueue.global(qos: .default)) { response in
            let urlResponse = response.response
            self.lastHeaders = urlResponse?.allHeaderFields

            if urlResponse?.isUnauthorized ?? false {
                self.logoutPresent()
                return
            }

            switch response.result {
            case let .success(value):
                if let dict = value.jsonObject() {
                    self.requestDidReturnRawReply(dict)
                } else {
                    self.requestDidReturnDataReply(response)
                }
            case let .failure(error):
                self.apiDidFailWithError(error)
            }
            self.apiDidEnd()
        }

        APIlog("Send request:\(String(describing: alamofireRequest))")
    }

    func logoutPresent() {
        DispatchQueue.main.async {
            //Будем показывать логин/пароль
        }
        apiDidFailWithError(NSError.error401(error: L10n.error, message: L10n.unauthorized))
    }

    func sendRequestWithDictCompletion(_ completion: APIDictCompletion?) {
        sendRequestWithCompletion { reply, error, handle in
            completion?(reply as? [String: Any], error, &handle)
        }
    }

    var onPrepareDefaultParameters: (() -> (AliasDictionary?))?

    // Creating
    func encodedURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: absolutePath)!)
        request.httpMethod = method.rawValue
        prepareURLRequest(&request)

        let parameters: [String: Any]?
        if self.parameters.isEmpty {
            parameters = onPrepareDefaultParameters?()
        } else {
            parameters = self.parameters
        }

        for (key, value) in headers {
            guard let value = value as? String else {
                continue
            }
            request.addValue(value, forHTTPHeaderField: key)
        }

        guard var encodedURLRequest = try? encoding.encode(request, with: parameters) else {
            return request
        }

        if let httpBody = encodedURLRequest.httpBody {
            let encodedBody = String(decoding: httpBody, as: UTF8.self)
            let fixXmlSlashes =
                encodedBody
                .replacingOccurrences(of: "<\\/", with: "</")
                .replacingOccurrences(of: "\\/>", with: "/>")
            encodedURLRequest.httpBody = fixXmlSlashes.data(using: .utf8)
        }
        if shouldLogRequest {
            print("parameters", parameters?.jsonString as Any)
        }
        return encodedURLRequest
    }

    public func prepareURLRequest(_ request: inout URLRequest) {
        request.allHTTPHeaderFields = allHTTPHeaderFields
        if shouldLogRequest {
            print("Headers", request.allHTTPHeaderFields as Any)
        }
        request.timeoutInterval = timeout
    }

    var allHTTPHeaderFields: HTTPHeaders {
        var dict = HTTPHeaders()
        dict["Content-Type"] = contentType
        dict["Accept"] = Constants.ContentType.applicationJson
        return dict
    }

    var contentType: String {
        return Constants.ContentType.applicationJson
    }

    override func cancel() {
        alamofireRequest?.cancel()
    }

    override func apiDidEnd() {
        super.apiDidEnd()

        alamofireRequest = nil
    }

    override var description: String {
        return "\(super.description), path:\(path)"
    }
}
