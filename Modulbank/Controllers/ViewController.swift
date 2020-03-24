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
        Router.showLoader()
        Router.removeLoader()
        // Do any additional setup after loading the view.
    }


}

