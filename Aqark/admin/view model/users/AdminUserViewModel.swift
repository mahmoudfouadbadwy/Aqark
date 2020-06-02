//
//  AdminViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

 class AdminUserViewModel{
    var userName : String = ""
    var userRating : Double = 0.0
    var userImage : String = ""
    
    init(adminUser : AdminUser) {
        self.userName = adminUser.userName
        self.userRating =  adminUser.userRating
        self.userImage = adminUser.userImage
    }
}
