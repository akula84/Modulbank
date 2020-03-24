//
//  PostAuthAPI.swift
//  BaseApp
//
//  Created by Alexander Tarasov on 26/06/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

class PostAuthAPI: PostAPI {
    
    private var grantType: String
    private var username: String
    private var password: String
    
    override var path: String {
        return "/oauth/token?grant_type=\(self.grantType)&username=\(self.username)&password=\(self.password)"
    }
    override var shouldAddAccessToken: Bool {
        return false
    }
    override var classForParsingReply: APIModel.Type? {
        return OauthToken.self
    }
    
    override var headers: [String: Any] {
        var headers = super.headers
        
        headers["Authorization"] = Constants.API.BasicAuthHeader
        
        return headers
    }
    
    init(username: String, password: String, grantType: String = Constants.API.DefaultGrantType) {
        self.grantType = grantType
        self.username  = username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        self.password  = password.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    override func showError(_ error: Error?) {  }
}
