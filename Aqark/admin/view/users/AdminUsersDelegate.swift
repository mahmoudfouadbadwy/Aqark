//
//  AdminUsersDelegate.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/4/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

protocol AdminUsersDelegate:class {
    func banUserDelegate(isBanned : Bool, at indexPath : IndexPath)
    func checkBannedUser(at indexPath : IndexPath) -> Bool
}
