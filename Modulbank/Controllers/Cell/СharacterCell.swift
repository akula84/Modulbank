//
//  СharacterCell.swift
//  Modulbank
//
//  Created by Артем Кулагин on 25.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import Alamofire
import UIKit

class СharacterCell: UITableViewCell {
    @IBOutlet var imageCharacter: UIImageView!
    @IBOutlet var loaderView: UIActivityIndicatorView!
    
    var item: CharacterItem? {
        didSet {
            prepareImage()
        }
    }

    func prepareImage() {
        imageCharacter.image = nil
        hiddenLoader()
        guard let imagePath = imagePath,
            let url = URL(string: imagePath) else {
            return
        }
        showLoader()
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url),
                let image: UIImage = UIImage(data: data) else {
                    self.hiddenLoader()
                return
            }
            DispatchQueue.main.async {
                self.hiddenLoader()
                guard self.imagePath == imagePath else {
                    return
                }
                // self.imageCache.setObject(image, forKey: NSString(string:        (activeUser?.login!)!))
                self.imageCharacter.image = image
            }
        }
    }
    
    func hiddenLoader() {
        loaderView.isHidden = true
    }
    
    func showLoader() {
        loaderView.isHidden = false
    }

    var imagePath: String? {
        item?.image
    }
}
