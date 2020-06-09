//
//  MockAdminDataAccess.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
@testable import Aqark

class MockAdminUserDataAccess {
    
    var shouldReturnError : Bool
    var usersArray : [[String:Any]]
    let userDictionary1 : [String : Any] = ["112233":
        ["username":"Zeyad",
         "role":"user",
         "phone":"",
         "email":"Zeyad@gmail.com",
         "country":"Cairo",
         "company":"",
         "rate":["1":3.0,"2":5.0]]]
    let userDictionary2 : [String : Any] = ["445566":
        ["username":"Fouad",
         "role":"user",
         "phone":"",
         "email":"Fouad@gmail.com",
         "country":"Cairo",
         "company":"ITI",
         "experience":"3"]]
    
    init(shouldReturnError:Bool) {
        self.shouldReturnError = shouldReturnError
        usersArray = [userDictionary1,userDictionary2]
    }
        
    func getUsers(completionForGetUsers : @escaping(_ usersData : [AdminUser]) -> Void){
        var users = [AdminUser]()
        for child in usersArray{
            users.append(self.createUser(child: child))
        }
        completionForGetUsers(users)
    }
    
    private func createUser(child:[String:Any]) -> AdminUser{
        let userId = child.keys.first
        let userDictionary = child[userId!] as! [String : Any]
        let userName = userDictionary[AdminUserKey.userName] as! String
        let userEmail = userDictionary[AdminUserKey.userEmail] as! String
        let userPhone = userDictionary[AdminUserKey.userPhone] as? String ?? "No Phone"
        let userCountry = userDictionary[AdminUserKey.userCountry] as? String ?? "No Country"
        let userCompany = userDictionary[AdminUserKey.userCompany] as? String ?? "No Company"
        let userRole = userDictionary[AdminUserKey.userRole] as! String
        let userExperience = userDictionary[AdminUserKey.userExperience] as? String ?? "Not Provided"
        let userRatingDic = userDictionary[AdminUserKey.userRating] as? [String:Any] ?? [:]
        let userRating = getUserRating(userRatingDic: userRatingDic)
        let userImage = userDictionary[AdminUserKey.userPicture] as?  String ?? ""
        let isBanned = userDictionary[AdminUserKey.banned] as? Bool ?? false
        let user = AdminUser(userId:userId!, userName: userName, userEmail: userEmail, userPhone: userPhone, userCountry: userCountry, userCompany: userCompany, userRole: userRole, userRating: userRating, userExperience: userExperience, userImage: userImage, isBanned: isBanned)
        return user
    }
    
    func getUserRating(userRatingDic : [String:Any])->Double{
        var userRating = 0.0
        if(userRatingDic.count == 0){
            return userRating
        }else{
            for rate in userRatingDic{
                userRating += rate.value as! Double
            }
            return userRating / Double(userRatingDic.count)
        }
    }
    
    func logout(completionForLogout:@escaping(_ error:String?)->Void){
        if(shouldReturnError){
            let error = "Logout error"
            completionForLogout(error)
        }else{
            completionForLogout(nil)
        }
    }
}

