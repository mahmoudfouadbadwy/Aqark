//
//  AdminAdvertisementCollectionViewCell.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/22/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminAdvertisementCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var advertisementImage: UIImageView!
    
    @IBOutlet weak var advertisementPropertyType: UILabel!
    @IBOutlet weak var advertisementPropertyPrice: UILabel!
    @IBOutlet weak var advertisementPropertyAddress: UILabel!
    @IBOutlet weak var advertisementPropertyBedNumbers: UILabel!
    @IBOutlet weak var advertisementPropertyBathNumbers: UILabel!
    @IBOutlet weak var advertisementPropertySize: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
