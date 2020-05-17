//
//  User.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct User{
    var email:String
    var password:String
    var username:String
    var phone:String
    var country:String
    var company:String
    var role:String
}

struct UserDictionary {
    var userDic:[String:String] = [:]
    init(user:User) {
        userDic["email"] = user.email
        userDic["username"] = user.username
        userDic["phone"] = user.phone
        userDic["country"] = user.country
        userDic["company"] = user.company
        userDic["role"] = user.role
        
    }
}
