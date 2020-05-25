//
//  AdminAdvertisementCollectionViewCell.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/22/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminAdvertisementCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var advertisementPropertyImage: UIImageView!
    @IBOutlet weak var advertisementPropertyType: UILabel!
    @IBOutlet weak var advertisementPropertyPrice: UILabel!
    @IBOutlet weak var advertisementPropertyAddress: UILabel!
    @IBOutlet weak var advertisementPropertyBedNumbers: UILabel!
    @IBOutlet weak var advertisementPropertyBathRoomNumbers: UILabel!
    @IBOutlet weak var advertisementPropertySize: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }

}
