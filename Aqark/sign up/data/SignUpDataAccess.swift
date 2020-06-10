//
//  Firebase.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
import ReachabilitySwift
class SignUpDataAccess{
    func createAccount(user:User,completion:@escaping(String,Bool)->Void) {
        if checkNetworkConnection()
        {
            Auth.auth().createUser(withEmail: user.email, password: user.password)
            { (res, error) in
                if let _ = res?.user, error == nil
                 {
                    self.createAccountDetails(by: user)
                    completion("Account Created Successfully.",true)
                 }
                else
                  {
                    completion(error!.localizedDescription,false)
                  }
            }
        }
        else
        {
            completion("Network connection not Available.",false)
        }
 }
    func createAccountDetails(by user:User){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        guard let userId = Auth.auth().currentUser?.uid else{return}
        let userDictionary:UserDictionary = UserDictionary(user: user)
        ref.child("Users").child(userId).setValue(userDictionary.userDic)
    }
    
    
    func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}
