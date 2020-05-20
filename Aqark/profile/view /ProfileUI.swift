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
        profilePicture.isHidden = true
        editProfile.isHidden = true
        bindData()
        showIndicator()
        setupOptionalViews(hide: true)
    }
    func setupOptionalViews(hide status:Bool)
    {
        optionalText.isHidden = status
        optionalIcons.isHidden = status
    }
    func setProfilePicture()
    {
        profilePicture.isHidden = false
    }
    func setCompanyName(with name:String)
    {
        if name.elementsEqual("")
        {
            self.companyName.text = "No Value"
        }else
        {
            self.companyName.text = name
        }
    }
    func setAddress(with address:String)
    {
        if (address.elementsEqual(""))
        {
            self.addressText.text = "No Value"
        }
        else
        {
            self.addressText.text = address
        }
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

