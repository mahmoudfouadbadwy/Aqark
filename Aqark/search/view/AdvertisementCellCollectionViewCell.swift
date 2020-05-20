//
//  AdvertisementCellCollectionViewCell.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdvertisementCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var advertisementImage: UIImageView!
    //    @IBOutlet weak var advertisementImage: UIImageView!
    @IBOutlet weak var propertyTypeLabel: UILabel!
    
    @IBOutlet weak var propertyPriceLabel: UILabel!
    
    @IBOutlet weak var proprtyAddressLabel: UILabel!
    
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    
    @IBOutlet weak var numberOfBathRoomsLabel: UILabel!
    
    @IBOutlet weak var propertySizeLabel: UILabel!
    
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        advertisementImage.layer.cornerRadius = 10
        advertisementImage.clipsToBounds = true
    }
   
    
}
