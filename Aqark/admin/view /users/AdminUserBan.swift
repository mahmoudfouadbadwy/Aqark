//
//  AdminUserBan.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension AdminUsersViewController:AdminUsersDelegate{
    
    func checkBannedUser(at indexPath: IndexPath) -> Bool {
        return adminUsersViewModel.adminUsersViewList[indexPath.row].isBanned
    }
    
    func banUserDelegate(isBanned : Bool ,at indexPath: IndexPath) {
        if(AdminNetworking.checkNetworkConnection()){
            let userId = adminUsersViewModel.adminUsersViewList[indexPath.row].userId
            adminUsersViewModel.banUser(isBanned: isBanned, userId: userId)
        }else{
            showAlert(title: "Connection".localize, message: "Internet Connection Not Available".localize)
        }
    }
}
