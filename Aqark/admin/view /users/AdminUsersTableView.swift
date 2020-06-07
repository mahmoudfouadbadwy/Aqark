//
//  AdminUsersTableView.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/5/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension AdminUsersViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminUsersViewModel.adminUsersViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = usersTableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath) as? AdminUserTableViewCell
        userCell?.adminUserCellIndex = indexPath
        userCell?.adminUserDelegate = self
        userCell?.userName.text = adminUsersViewModel.adminUsersViewList[indexPath.row].userName
        userCell?.userRating.rating = adminUsersViewModel.adminUsersViewList[indexPath.row].userRating
        let userImageURL = URL(string: adminUsersViewModel.adminUsersViewList[indexPath.row].userImage)
        userCell?.userImage.sd_setImage(with: userImageURL, placeholderImage: UIImage(named: "profile_user"))
        userCell?.banUserButton.setTitle(adminUsersViewModel.adminUsersViewList[indexPath.row].isBanned ? "Unban" : "Ban", for: .normal)
        return userCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension AdminUsersViewController:AdminUsersDelegate{
    
    func checkBannedUser(at indexPath: IndexPath) -> Bool {
        return adminUsersViewModel.adminUsersViewList[indexPath.row].isBanned
    }
    
    func banUserDelegate(isBanned : Bool ,at indexPath: IndexPath) {
        let userId = adminUsersViewModel.adminUsersViewList[indexPath.row].userId
        adminUsersViewModel.banUser(isBanned: isBanned, userId: userId)
    }
}
