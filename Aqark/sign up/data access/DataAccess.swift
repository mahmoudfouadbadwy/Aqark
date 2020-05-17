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
class DataAccess{
    func createAccount(user:User,completion:@escaping(String)->Void) {
        if checkNetworkConnection()
        {
            Auth.auth().createUser(withEmail: user.email, password: user.password)
            { (res, error) in
                if let _ = res?.user, error == nil
                 {
                    self.createAccountDetails(by: user)
                    completion("Account Created Successfully.")
                 }
                else
                  {
                    completion(error!.localizedDescription)
                  }
            }
        }
        else
        {
            completion("Network connection not Available.")
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
