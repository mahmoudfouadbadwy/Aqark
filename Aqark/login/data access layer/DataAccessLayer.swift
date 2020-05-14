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
    func login(userEmail:String,userPassword:String){
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, error) in
            print(error.debugDescription)
        }
    }
}
