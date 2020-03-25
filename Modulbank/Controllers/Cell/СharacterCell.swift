//
//  СharacterCell.swift
//  Modulbank
//
//  Created by Артем Кулагин on 25.03.2020.
//  Copyright © 2020 Артем Кулагин. All rights reserved.
//

import Alamofire
import UIKit
import Kingfisher

class СharacterCell: UITableViewCell {
    @IBOutlet var imageCharacter: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var item: CharacterItem? {
        didSet {
            nameLabel.text = item?.name
            prepareImage()
        }
    }
    
    func prepareImage() {
        imageCharacter.image = nil
        imageCharacter.kf.cancelDownloadTask()
        guard let imagePath = imagePath,
            let url = URL(string: imagePath) else {
            return
        }
        imageCharacter.kf.setImage(with: url)
    }

    var imagePath: String? {
        item?.image
    }
}
