//
//  ProfileUI.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK: - Profile Data
extension ProfileViewController{
    func setupView()
    {
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.white.cgColor
        self.profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
        self.username.textColor = UIColor(rgb: 0x1d3557)
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        self.rate.backgroundColor = UIColor(rgb: 0xf1faee)
        self.advertisementsCollection.backgroundColor = UIColor(rgb: 0xf1faee)
        hideAllElements(status: true)
        rate.settings.updateOnTouch = false
        rate.settings.emptyBorderColor = UIColor(rgb: 0x1d3557)
        rate.settings.filledColor = UIColor(rgb: 0x1d3557)
        rate.settings.filledBorderColor = UIColor(rgb: 0x1d3557)
        
    }
    func hideAllElements(status:Bool)
    {
        profilePicture.isHidden = status
        addAdvertisement.isHidden = status
        rate.isHidden = status
    }

    func setUpNoConnectionView()
    {
        hideAllElements(status: true)
        noAdvertisementsLabel.isHidden = false
        noAdvertisementsLabel.text = "Internet Connection Not Available".localize
        
    }
    
}


