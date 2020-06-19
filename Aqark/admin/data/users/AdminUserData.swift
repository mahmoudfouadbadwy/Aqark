//
//  AdminDataAccessLayer.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
class AdminDataAccess{
     var databaseHandle: DatabaseHandle!

    var usersRef : DatabaseReference! = Database.database().reference()
    var advertisementsRef : DatabaseReference! = Database.database().reference()
    var deleteUserAdvertisementRef : DatabaseReference! = Database.database().reference()
    var delelteAdvertisementRef : DatabaseReference! = Database.database().reference()
    
    func getUsers(completionForGetUsers : @escaping(_ usersData : [AdminUser]) -> Void){
        var users = [AdminUser]()
        
        usersRef.child("Users").observe(.value) { (snapShot) in
            users.removeAll()
            for child in snapShot.children.allObjects as! [DataSnapshot]{
                users.append(self.createUser(child: child))
            }
            completionForGetUsers(users)
        }
    }
    
    func banUser(isBanned : Bool,userId : String){
        usersRef.child("Users").child(userId).child("banned").setValue(isBanned)
    }
    
    private func createUser(child:DataSnapshot) -> AdminUser{
        let userId = child.key
        let userDictionary = child.value as! [String : Any]
        let userName = userDictionary[AdminUserKey.userName] as? String ?? ""
        let userEmail = userDictionary[AdminUserKey.userEmail] as? String ?? ""
        let userPhone = userDictionary[AdminUserKey.userPhone] as? String ?? "No Phone"
        let userCountry = userDictionary[AdminUserKey.userCountry] as? String ?? ","
        let userCompany = userDictionary[AdminUserKey.userCompany] as? String ?? "No Company"
        let userRole = userDictionary[AdminUserKey.userRole] as? String ?? ""
        let userExperience = userDictionary[AdminUserKey.userExperience] as? String ?? "Not Provided"
        let userRatingDic = userDictionary[AdminUserKey.userRating] as? [String:Any] ?? [:]
        let userRating = getUserRating(userRatingDic: userRatingDic)
        let userImage = userDictionary[AdminUserKey.userPicture] as?  String ?? ""
        let isBanned = userDictionary[AdminUserKey.banned] as? Bool ?? false
        let user = AdminUser(userId:userId, userName: userName, userEmail: userEmail, userPhone: userPhone, userCountry: userCountry, userCompany: userCompany, userRole: userRole, userRating: userRating, userExperience: userExperience, userImage: userImage, isBanned: isBanned)
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
    
    func removeUsersObservers(){
        usersRef.child("Users").removeAllObservers()
        usersRef = nil
    }
}
