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
    
    func logout()
      {
          let firebaseAuth = Auth.auth()
          do {
              try firebaseAuth.signOut()
          } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
          }
      }
}
