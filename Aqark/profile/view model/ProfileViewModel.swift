//
//  ProfileViewModel.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import ReachabilitySwift
import Firebase
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
    
    func logout()
    {
        profileDataAccess.profileLogout()
    }
    
    
}
class ProfileViewModel{
    var role:String
    var picture:String
    var username:String
    var country:String
    var address:String
    var company:String
    var phone:String
    var experience:String
    var rate:[String:Double]
    var ban:Bool
    init(profile:Profile) {
        self.role = profile.role
        self.picture = profile.picture
        self.rate = profile.rate
        self.username = profile.username
        self.company = profile.company
        self.address = profile.address
        self.phone = profile.phone
        self.country = profile.country
        self.experience = profile.experience
        self.ban = profile.ban
    }
}


struct ProfileNetworking{
    
    static func checkAuthuntication()->Bool{
        var status:Bool = false
        if Auth.auth().currentUser != nil{
            status = true
        }
        return status
    }
    
    static func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
    
    static func isAdmin()->Bool
    {
        guard let user =  Auth.auth().currentUser else {return false}
        if user.email!.elementsEqual("aqark@admin.com")
        {
            return true
        }
        return false
    }
}
