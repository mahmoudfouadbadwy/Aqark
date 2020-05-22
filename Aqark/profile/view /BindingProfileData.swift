//
//  BindingProfileData.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK: - Bind Data
extension ProfileViewController{
    func bindProfileData()
    {
        let profileViewModel:ProfileStore = ProfileStore(by: profileDataAccess)
        profileViewModel.getProfileData(onSuccess: {[weak self]
            (profileData) in
            self?.hideAllElements(status: false)
            self?.username.text = profileData.username
            self?.setProfilePicture(url:profileData.picture)
            self?.rate.rating = profileData.rate
            if profileData.role.lowercased().elementsEqual("user")
            {
                self?.setupOptionalViews(hide: true)
            }
            else
            {
                self?.countryName.text = profileData.country
                self?.setCompanyName(with: profileData.company)
                self?.setAddress(with: profileData.address)
                self?.phoneValue.text = profileData.phone
                self?.setExperience(exp: profileData.experience)
                self?.setupOptionalViews(hide: false)
            }
            
            }, onFailure: {
                (error) in
                print("\(error.localizedDescription)")
        })
    }
    
    private func setProfilePicture(url:String)
    {
        profilePicture.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "profile_user"))
    }
    private  func setCompanyName(with name:String)
    {
        if name.elementsEqual("")
        {
            self.companyName.text = "No Value"
        }else
        {
            self.companyName.text = name
        }
    }
    private   func setAddress(with address:String)
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
    private func setExperience(exp:String)
    {
        if (exp.elementsEqual(""))
        {
            self.experienceValue.text = "No Value"
        }
        else
        {
            self.experienceValue.text =  exp
        }
    }
}




