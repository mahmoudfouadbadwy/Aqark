//
//  ProfileAdvertisementCell.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AgentAdvertisementCell: UICollectionViewCell {

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
    }

}


