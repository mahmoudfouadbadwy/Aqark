//
//  AdminViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

 struct AdminUserViewModel{
    var userId : String = ""
    var userName : String = ""
    var userRating : Double = 0.0
    var userImage : String = ""
    var isBanned : Bool = false
    
    init(adminUser : AdminUser) {
        self.userId = adminUser.userId
        self.userName = adminUser.userName
        self.userRating =  adminUser.userRating
        self.userImage = adminUser.userImage
        self.isBanned = adminUser.isBanned
    }
}
