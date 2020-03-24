//
//  ViewController.swift
//  Modulbank
//
//  Created by Артем Кулагин on 24.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func actionButton(_ sender: Any) {
        Router.showLoader()
        AuthManager.login(username: "iperkina", password: "1234") { [weak self] (success, error) in
            DispatchQueue.main.async {
                print("success", success)
                Router.removeLoader()
            }
        }
        
    }
    
    @IBAction func actionButton2(_ sender: Any) {
        let vc = TestController.controller()
        print("actionButton2", vc)
        Router.pushViewController(vc)
    }
    
}

