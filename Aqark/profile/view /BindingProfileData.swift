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
            self?.setUserRate(rate:profileData.rate)
            self?.ban = profileData.ban
            if profileData.role.lowercased().elementsEqual("user")
            {
                 self?.setupOptionalViews(hide: true)
                 self?.containerStack.spacing = 0
                 self?.containerHeight.constant = 0
            }
            else
            {
                self?.countryName.text = profileData.country.localize
                self?.setCompanyName(with: profileData.company)
                self?.setAddress(with: profileData.address)
                self?.phoneValue.text = (self?.convertNumbers(lang: "lang".localize, stringNumber:"0").1)! + (self?.convertNumbers(lang: "lang".localize, stringNumber: profileData.phone).1)!
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
            if exp.elementsEqual("1")
            {
                if "lang".localize.elementsEqual("en"){
                     self.experienceValue.text =  self.convertNumbers(lang: "lang".localize, stringNumber: exp).1 + "year"
                }else{
                    self.experienceValue.text =  "year".localize
                }
               
            }
            else
            {
                self.experienceValue.text =  self.convertNumbers(lang: "lang".localize, stringNumber: exp).1 + "years".localize
            }
            
        }
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




