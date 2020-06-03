//
//  ServiceUserViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class ServiceUserViewModel{
    var serviceUserId : String = ""
    var serviceUserName : String = ""
    var serviceUserCountry : String = ""
    var serviceUserRating : String = ""
    var serviceUserExperience : String = ""
    var serviceUserCompany : String = ""
    var ServiceUserImage : String = ""
    
    init(serviceUser : ServiceUser) {
        self.serviceUserId = serviceUser.userId
        self.serviceUserName = serviceUser.userName
        self.serviceUserCountry  = serviceUser.userCountry
        self.serviceUserRating = serviceUser.userRating
        self.serviceUserExperience = serviceUser.userExperience
        self.serviceUserCompany = serviceUser.userCompany
        self.ServiceUserImage = serviceUser.userImage
    }
}