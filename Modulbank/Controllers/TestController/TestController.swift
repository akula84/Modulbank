//
//  TestController.swift
//  Modulbank
//
//  Created by Артем Кулагин on 24.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import UIKit

class TestController: UIViewController {
    
    @IBAction func buttonAction(_ sender: Any) {
        loadItems()
    }
    
    func loadItems() {
        Router.showLoader()
        /*
        GetDealDocTypes(sync: false, object: nil) { [weak self] (reply, _, _) in
            DispatchQueue.main.async {
                Router.removeLoader()
                guard let items = reply as? [DealDocType], !items.isEmpty else {
                    MessageCenter.showMessage(L10n.errorLoadingFileTypes)
                    return
                }
                MessageCenter.showMessage("ОК")
                print("GetDealDocTypes", items)
            }
            
        }
        */
        
        GetDealDocTypes(sync: false, object: nil) { (reply, _, _) in
            DispatchQueue.main.async {
                Router.removeLoader()
                guard let items = reply as? [AliasDictionary], !items.isEmpty else {
                    MessageCenter.showMessage(L10n.errorLoadingFileTypes)
                    return
                }
                let result = RNSDataManager.parseDataBuss(items)
                MessageCenter.showMessage("ОК")
                print("GetDealDocTypes", items, result.count)
                print("GetDealDocTypes2", RNSDataManager.items?.count)
            }
            
        }
    }
}
