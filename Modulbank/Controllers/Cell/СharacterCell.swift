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
    @IBOutlet var nameLabel: UILabel!
    
    var item: CharacterItem? {
        didSet {
            nameLabel.text = item?.name
            prepareImage()
        }
    }
    
    func prepareImage() {
        imageCharacter.image = nil
        hiddenLoader()
        let imageCache = CasheManager.imageCache
        guard let imagePath = imagePath,
            let url = URL(string: imagePath) else {
            return
        }
        if let image = imageCache.object(forKey: NSString(string: imagePath)) {
            imageCharacter.image = image
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
                imageCache.setObject(image, forKey: NSString(string: imagePath))
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
