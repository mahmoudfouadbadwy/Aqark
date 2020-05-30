//
//  AdminUsersListViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class AdminUsersListViewModel{
    
    var adminUsersViewList : [AdminUserViewModel] = [AdminUserViewModel]()
    var adminUsersList : [AdminUserViewModel] = [AdminUserViewModel]()
    var adminLawyersList : [AdminUserViewModel] = [AdminUserViewModel]()
    var adminInteriorDesignersList : [AdminUserViewModel] = [AdminUserViewModel]()
    let dataAccess : AdminDataAccess
    
    init(dataAccess:AdminDataAccess) {
        self.dataAccess = dataAccess
    }
    
    func populateUsers(completionForPopulateUsers : @escaping() -> Void){
        dataAccess.getUsers { (usersData) in
            self.adminUsersList.removeAll()
            self.adminLawyersList.removeAll()
            self.adminInteriorDesignersList.removeAll()
            self.filter(allUsersData: usersData)
            //            self.adminUsersList = usersData.map { userData in
            //                return AdminUserViewModel(adminUser: userData)
            //            }
            completionForPopulateUsers()
        }
    }
    
    private func filter(allUsersData : [AdminUser]){
        for user in allUsersData{
            switch user.userRole.lowercased() {
            case AdminUserRole.user:
                let user = AdminUserViewModel(adminUser: user)
                adminUsersList.append(user)
            case AdminUserRole.lawyer.lowercased():
                let lawyer = AdminUserViewModel(adminUser: user)
                adminLawyersList.append(lawyer)
            default:
                let interiorDesigner = AdminUserViewModel(adminUser: user)
                adminInteriorDesignersList.append(interiorDesigner)
            }
        }
        adminUsersViewList = adminUsersList
    }
    
    func getUsersByType(type:Int){
        switch type {
        case 0:
            adminUsersViewList = adminUsersList
        case 1:
            adminUsersViewList = adminLawyersList
        default:
            adminUsersViewList = adminInteriorDesignersList
        }
    }
    
    func getFilteredUsers(type:Int,searchText:String){
        if(searchText.isEmpty){
            switch type {
            case 0:
                adminUsersViewList = adminUsersList
            case 1:
                adminUsersViewList = adminLawyersList
            default:
                adminUsersViewList = adminInteriorDesignersList
            }
        }else{
            switch type{
            case 0:
                adminUsersViewList = adminUsersList.filter{(user:AdminUserViewModel) -> Bool in
                    return user.userName.lowercased().contains(searchText.lowercased())
                }
            case 1:
                adminUsersViewList = adminLawyersList.filter{(user:AdminUserViewModel) -> Bool in
                    return user.userName.lowercased().contains(searchText.lowercased())
                }
            default:
                adminUsersViewList = adminInteriorDesignersList.filter{(user:AdminUserViewModel) -> Bool in
                    return user.userName.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
    func logout(){
        dataAccess.logout()
    }
}

