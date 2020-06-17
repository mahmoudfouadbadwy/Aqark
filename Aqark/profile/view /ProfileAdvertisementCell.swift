//
//  ProfileAdvertisementCell.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class ProfileAdvertisementCell: UICollectionViewCell {

    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var paymentType: UILabel!
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
        paymentType.textColor = UIColor(rgb: 0x1d3557)
        propertyType.textColor = UIColor(rgb: 0x457b9d)
    }

}

extension UIImageView{
    func setRaduisForImage()
    {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
