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
        hideAllElements(status: true)
        rate.settings.updateOnTouch = false
    }
     func hideAllElements(status:Bool)
    {
        profilePicture.isHidden = status
        editProfile.isHidden = status
        rate.isHidden = status
        setupOptionalViews(hide: status)
    }
    func setupOptionalViews(hide status:Bool)
    {
        containerStack.isHidden = status
        containerHeight.constant = 0
    }
    func setUpNoConnectionView()
    {
        hideAllElements(status: true)
        noAdvertisementsLabel.isHidden = false
        noAdvertisementsLabel.text = "Internet Connection Not Available"
        
    }
}

//MARK: - UIViewIndicator
extension ProfileViewController{
    func showIndicator()
    {
        networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
    func stopIndicator() {
        networkIndicator.stopAnimating()
    }
}

