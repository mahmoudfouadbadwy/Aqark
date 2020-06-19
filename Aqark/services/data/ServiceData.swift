//
//  ServiceDataAccessLayer.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

class ServiceDataAccess{
    
    var serviceUsersRef : DatabaseReference! = Database.database().reference().child("Users")

    func getServiceUsers(completionForGetServiceUsers:@escaping(_ serviceUsers:[ServiceUser])->Void){
        var serviceUsers = [ServiceUser]()
        serviceUsersRef.observe(.value) { (dataSnapShot) in
            serviceUsers.removeAll()
            for child in dataSnapShot.children.allObjects as! [DataSnapshot]{
                serviceUsers.append(self.createServiceUser(child: child))
            }
            completionForGetServiceUsers(serviceUsers)
        }
    }
    
    private func createServiceUser(child:DataSnapshot) -> ServiceUser{
        let serviceUserId = child.key
        let serviceUserDictionary = child.value as! [String : Any]
        let serviceUserName = serviceUserDictionary[ServiceUserKey.userName] as? String ?? ""
        let serviceUserEmail = serviceUserDictionary[ServiceUserKey.userEmail] as? String ?? ""
        let serviceUserPhone = serviceUserDictionary[ServiceUserKey.userPhone] as? String ?? ""
        let serviceUserCountry = serviceUserDictionary[ServiceUserKey.userCountry] as? String ?? ","
        let serviceUserCompany = serviceUserDictionary[ServiceUserKey.userCompany] as? String ?? ""
        let serviceUserRole = serviceUserDictionary[ServiceUserKey.userRole] as? String ?? ""
        let serviceUserExperience = serviceUserDictionary[ServiceUserKey.userExperience] as? String ?? ""
        let serviceUserRatingDic = serviceUserDictionary[ServiceUserKey.userServiceRating] as? [String:Any] ?? [:]
        let serviceUserServiceRating = getUserServiceRating(userRatingDic: serviceUserRatingDic)
        let serviceUserImage = serviceUserDictionary[ServiceUserKey.userPicture] as? String ?? ""
        let user = ServiceUser(userId:serviceUserId, userName: serviceUserName, userEmail: serviceUserEmail, userPhone: serviceUserPhone, userCountry: serviceUserCountry, userCompany: serviceUserCompany, userRole: serviceUserRole, userServiceRating: serviceUserServiceRating, userExperience: serviceUserExperience, userImage: serviceUserImage)
        return user
    }
    
    func rateServiceUser(rate:Double,userId:String,serviceUserId:String){
        let serviceRate = ["\(userId)":rate]
        serviceUsersRef.child(serviceUserId).child("service rate").setValue(serviceRate)
    }
    
     func getUserServiceRating(userRatingDic : [String:Any])->Double{
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
    
    func removeServicesObservers(){
        serviceUsersRef.removeAllObservers()
        serviceUsersRef = nil
    }
}
