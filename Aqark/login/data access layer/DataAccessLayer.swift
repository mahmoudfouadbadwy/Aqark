//
//  DataAccessLayer.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/13/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

class DataAccessLayer{
    func login(userEmail:String,userPassword:String,completionForLogin:@escaping(_ result:String?,_ error:String?)->Void){
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, error) in
            
            if(error != nil){
                completionForLogin(nil,error!.localizedDescription)
            }else{
                completionForLogin("Successfully Logged in \(result?.user.email ?? "user")",nil)
            }
        }
    }
}
