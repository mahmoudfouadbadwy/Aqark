//
//  AdminDelete.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

extension AdminDataAccess{
    
    func logout(completionForLogout:@escaping(_ error:String?)->Void){
          let firebaseAuth = Auth.auth()
          do {
              try firebaseAuth.signOut()
              completionForLogout(nil)
          } catch let signOutError as NSError {
            completionForLogout(signOutError.localizedDescription)
            print ("Error signing out: %@", signOutError)
          }
      }
}
