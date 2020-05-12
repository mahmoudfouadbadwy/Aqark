//
//  Firebase.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

class DataLayer{
    func createAccount(email:String,password:String){
        Auth.auth().createUser(withEmail: email, password: password, completion:nil);
    }
}
