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
        if profileViewModel != nil {
            profileViewModel.getProfileData(onSuccess: {[weak self]
                (profileData) in
                self?.hideAllElements(status: false)
                self?.username.text = profileData.username
                self?.setProfilePicture(url:profileData.picture)
                self?.setUserRate(rate:profileData.rate)
                self?.ban = profileData.ban
                }, onFailure: {
                    (error) in
                    print("\(error.localizedDescription)")
            })
        }
    }
    
    private func setProfilePicture(url:String)
    {
        profilePicture.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "profile_user"))
    }
    private func setUserRate(rate:[String:Double])
    {
        let rates = rate
        var userRate:Double = 0
        for rate in rates
        {
            userRate += rate.value
        }
        if rates.count > 0 {
            userRate /= Double(rates.count )
        }
        self.rate.settings.fillMode =  .precise
        self.rate.rating = userRate
        
    }
    
}




