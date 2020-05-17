//
//  ProfileAdvertisementCell.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class ProfileAdvertisementCell: UICollectionViewCell {

    @IBOutlet weak var propertyImage: UIImageView!
    @IBOutlet weak var propertyType: UILabel!
    @IBOutlet weak var propertyPrice: UILabel!
    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var bedNumber: UILabel!
    @IBOutlet weak var bathRoomNumber: UILabel!
    @IBOutlet weak var propertySize: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        propertyImage.setRaduisForImage()
    }

}

extension UIImageView{
    func setRaduisForImage()
    {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}
