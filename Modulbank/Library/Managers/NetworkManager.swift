//
//  NetworkManager.swift
//  BaseApp
//
//  Created by Alexander Tarasov on 27/06/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Alamofire

public typealias NetworkManagerGoOnlineCompletion = (_ success: Bool) -> Void

class NetworkManager {
    
    var reachability: Monitor?
    var reachabilitySubscription: NetworkStatusSubscription?
    
    static let shared = NetworkManager()

    private var isOldServerReachable = true
    
    init() {
        prepareMonitor()
        updateOldStatus()
    }
    
    func updateOldStatus() {
        isOldServerReachable = isServerReachable
    }
    
    var isOnline: Bool {
        return isServerReachable
    }
    
    static var isOnline: Bool {
        return shared.isOnline
    }
    

    var isOffline: Bool {
        return !isServerReachable
    }
    
    static var isOffline: Bool {
        return shared.isOffline
    }
  
    /* Возможно пригодится не удалять
    // Go to Online mode
    func goOnline(completion: @escaping NetworkManagerGoOnlineCompletion) {
        // If server not available - we can't go to Online mode
        if !isServerReachable() {
            self.mode = .offline
            completion(false)
            return
        }
        
        // Check server connectivity
        Alamofire.request(Constants.API.BaseURL).responseJSON { [weak self] response in
            if response.result.error != nil {
                self?.mode = .offline
                completion(false)
            }
            else {
                self?.mode = .online
                completion(true)
            }
        }
    }
    */

    private var isServerReachable: Bool {
        return reachability?.status != .notReachable
    }
}

extension NetworkManager: NetworkStatusSubscriber {
    func prepareMonitor() {
        reachability = Monitor(withURL: NSURL(string: Constants.API.BaseURL)!)
        _ = reachability?.start()
        reachabilitySubscription = reachability?.addSubscription(using: self)
    }
    
    func networkStatusChanged(status: ReachabilityStatus) {
        checkStatus()
    }
    
    static func checkStatus(forced: Bool = false) {
        shared.checkStatus()
    }
    
    func checkStatus(forced: Bool = false) {
        guard forced || (isOldServerReachable != isServerReachable) else {
            return
        }
        updateOldStatus()
        post()
    }
    
    func post() {
        DispatchQueue.main.async {
            /*
            NotificationCenter.postUserModeChanged()
            Router.showRunTimeLoginIfNeed()
            if Constants.isInPilotMode {
                Router.hideOfflineLoginIfNeed()
            }
            */
        }
    }
}
