//
//  EditBindData.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 6/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension EditProfileViewController{
    func fetchProfileDataFromFirebase()
    {
        profileData = ProfileDataAccess()
        profileStore = ProfileStore(by: profileData!)
        profileStore?.getProfileData( onSuccess:{[weak self] (profile) in
            if (profile.role.lowercased().elementsEqual("user"))
            {
                self?.phoneNumberTxtField.isHidden = true
                self?.addressTxtField.isHidden = true
                self?.companyTxtField.isHidden = true
                self?.experianceTxtField.isHidden = true
                self?.stepperExperiance.isHidden = true
            }
            if(profile.picture.isEmpty == false)
            {
                self?.imageView.sd_setImage(with: URL(string: profile.picture), placeholderImage: UIImage(named: "profile_user"))
                self?.profilePic = profile.picture
            }
            if(profile.username.isEmpty == false)
            {
                self?.userNameTxtField.text = profile.username
            }
            if(profile.phone.isEmpty == false)
            {
                self?.phoneNumberTxtField.text = (self?.convertNumbers(lang: "lang".localize, stringNumber:"0").1 ?? "0") + (self?.convertNumbers(lang: "lang".localize, stringNumber: profile.phone).1 ?? "0")
            }
            if(profile.country.isEmpty == false)
            {
                self?.addressTxtField.text = profile.country
            }
            
            if(profile.company.isEmpty == false)
            {
                self?.companyTxtField.text = profile.company
            }
            if(profile.experience.isEmpty == false)
            {
                self?.experianceTxtField.text = self?.convertNumbers(lang: "lang".localize, stringNumber: profile.experience).1
                self?.stepperExperiance.value = self?.convertNumbers(lang: "lang".localize, stringNumber: profile.experience).0.doubleValue ?? 0
            }
            self?.role = profile.role
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
