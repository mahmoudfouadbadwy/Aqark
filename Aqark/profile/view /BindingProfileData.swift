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
    func bindData()
    {
        let profileViewModel:ProfileStore = ProfileStore(by: profileDataAccess)
        profileViewModel.getProfileData(onSuccess: {[weak self]
            (profileData) in
            self?.stopIndicator()
            self?.userRole.text = profileData.role
            self?.username.text = profileData.username
            self?.email.text = profileData.email
            self?.setProfilePicture()
            self?.editProfile.isHidden = false
            if profileData.role.lowercased().elementsEqual("user")
            {
                self?.setupOptionalViews(hide: true)
            }
            else
            {
                self?.countryName.text = profileData.country
                self?.setCompanyName(with: profileData.company)
                self?.setAddress(with: profileData.address)
                self?.setExperience(with: profileData.experience)
                self?.setupOptionalViews(hide: false)
            }
            
            }, onFailure: {
                (error) in
                print("\(error.localizedDescription)")
        })
    }
}




