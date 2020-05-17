//
//  ProfileData.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
class ProfileDataAccess{
    
    func getProfileData(onSuccess:@escaping(Profile)->Void,onFailure:@escaping(Error)-> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            let userRole = value?["role"] as? String ?? ""
            let picture = value?["picture"] as? String ?? ""
            let country = value?["country"] as? String ?? ""
            let address = value?["address"] as? String ?? ""
            let company = value?["company"] as? String ?? ""
            let experience = value?["experience"] as? String ?? ""
            let profile:Profile = Profile(role: userRole, picture: picture, username: username, email: email, country: country, address: address, company: company, experience: experience)
            onSuccess(profile)
        }) { (error) in
            onFailure(error)
        }
    }
}

