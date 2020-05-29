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
        
    func getServiceUsers(completionForGetServiceUsers:@escaping(_ serviceUsers:[ServiceUser])->Void){
        var serviceUsers = [ServiceUser]()
        let serviceUsersRef = Database.database().reference().child("Users")
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
           let serviceUserName = serviceUserDictionary[ServiceUserKey.userName] as! String
           let serviceUserEmail = serviceUserDictionary[ServiceUserKey.userEmail] as! String
           let serviceUserPhone = serviceUserDictionary[ServiceUserKey.userPhone] as? String ?? "No Phone"
           let serviceUserCountry = serviceUserDictionary[ServiceUserKey.userCountry] as? String ?? "No Country"
           let serviceUserCompany = serviceUserDictionary[ServiceUserKey.userCompany] as? String ?? "No Company"
           let serviceUserRole = serviceUserDictionary[ServiceUserKey.userRole] as! String
           let serviceUserExperience = "4"
           let serviceUserRating = "4"
           let serviceUserImage = "https://cdn1.vectorstock.com/i/1000x1000/26/40/profile-placeholder-image-gray-silhouette-no-vector-22122640.jpg"
           let user = ServiceUser(userId:serviceUserId, userName: serviceUserName, userEmail: serviceUserEmail, userPhone: serviceUserPhone, userCountry: serviceUserCountry, userCompany: serviceUserCompany, userRole: serviceUserRole, userRating: serviceUserRating, userExperience: serviceUserExperience, userImage: serviceUserImage)
           return user
       }
}
