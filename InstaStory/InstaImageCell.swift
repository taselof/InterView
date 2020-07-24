//
//  InstaImageCell.swift
//  InstaStory
//
//  Created by ozgen dindar on 22.07.2020.
//  Copyright © 2020 ozgen dindar. All rights reserved.
//

import UIKit
import Kingfisher

class InstaImageCell: UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    
    func config(url: URL){
        self.image.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "hp"))
    }
}
