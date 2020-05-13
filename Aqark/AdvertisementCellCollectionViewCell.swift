//
//  AdvertisementCellCollectionViewCell.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdvertisementCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var advertisementImage: UIImageView!
    @IBOutlet weak var propertyTypeLabel: UILabel!
    
    @IBOutlet weak var propertyPriceLabel: UILabel!
    
    @IBOutlet weak var proprtyAddressLabel: UILabel!
    
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    
    @IBOutlet weak var numberOfBathRoomsLabel: UILabel!
    
    @IBOutlet weak var propertySizeLabel: UILabel!
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    public func configure(with model: SearchModel) {
        advertisementImage.image = model.image
        propertyTypeLabel.text = model.propertyType
        propertyPriceLabel.text = model.price
        proprtyAddressLabel.text =  model.address
        propertySizeLabel.text = model.size
        numberOfBedsLabel.text = model.bedRoomsNumber
        numberOfBathRoomsLabel.text = model.bathRoomsNumber
        
        
    }
    
}
