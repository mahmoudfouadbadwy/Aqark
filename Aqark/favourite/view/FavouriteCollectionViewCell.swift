//
//  FavouriteCollectionViewCell.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var advertisementImage: UIImageView!
    @IBOutlet weak var propertyTypeLabel: UILabel!
    @IBOutlet weak var propertyPriceLabel: UILabel!
    @IBOutlet weak var proprtyAddressLabel: UILabel!
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    @IBOutlet weak var numberOfBathRoomsLabel: UILabel!
    @IBOutlet weak var propertySizeLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    var delegat:FavouriteProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        advertisementImage.layer.cornerRadius = 10
        advertisementImage.clipsToBounds = true
        propertyTypeLabel.textColor = UIColor(rgb: 0x457b9d)
    }
    
    @IBAction func addToFavoutiteButtonMethod(_ sender: Any) {
        
        delegat?.addToFav(favButton: sender as! UIButton)
    }
  
}
