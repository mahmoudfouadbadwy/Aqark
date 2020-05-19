//
//  AddAdvertisementsCollectionViewCell.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AddAdvertisementsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageForCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        imageForCell.layer.cornerRadius = 10
        
    }

}
