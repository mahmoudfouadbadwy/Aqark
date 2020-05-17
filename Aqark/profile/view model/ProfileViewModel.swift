//
//  ProfileViewModel.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class ProfileStore{
    var profileDataAccess:ProfileDataAccess!
    init(by profileDataAccess:ProfileDataAccess) {
        self.profileDataAccess = profileDataAccess
    }
    
    func  getProfileData(onSuccess:@escaping(ProfileViewModel)->Void,onFailure:@escaping(Error)->Void)
    {
    profileDataAccess.getProfileData(onSuccess: {
    (profileData) in
         onSuccess(ProfileViewModel(profile: profileData))
    }, onFailure: {
    (error) in
        onFailure(error)
    })
    }
    
    
}
class ProfileViewModel{
    var role:String
    var picture:String
    var username:String
    var email:String
    var country:String
    var address:String
    var company:String
    var experience:String
    init(profile:Profile) {
        self.role = profile.role
        self.picture = profile.picture
        self.email = profile.email
        self.username = profile.username
        self.company = profile.company
        self.address = profile.address
        self.experience = profile.experience
        self.country = profile.country
    }
}
