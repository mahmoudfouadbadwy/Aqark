//
//  ServiceUsersListViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class ServicesListViewModel{
    
    var serviceUsersViewList : [ServiceUserViewModel]  = [ServiceUserViewModel]()
    var serviceLawyersList : [ServiceUserViewModel] = [ServiceUserViewModel]()
    var serviceInteriorDesignersList : [ServiceUserViewModel] = [ServiceUserViewModel]()
    var dataAccess : ServiceDataAccess?
    
    init(dataAccess:ServiceDataAccess) {
        self.dataAccess = dataAccess
    }
    
    func getServiceUsers(completionForGetServiceUsers:@escaping() -> Void){
        dataAccess?.getServiceUsers(){(serviceUsers) in
            self.serviceUsersViewList.removeAll()
            self.serviceLawyersList.removeAll()
            self.serviceInteriorDesignersList.removeAll()
            self.filterUsers(serviceUsers: serviceUsers)
            completionForGetServiceUsers()
        }
    }
    
    func getServiceUsersList(serviceUserRole : String){
        if(serviceUserRole.elementsEqual(ServiceUserRole.lawyer)){
            serviceUsersViewList = serviceLawyersList
        }else{
            serviceUsersViewList = serviceInteriorDesignersList
        }
    }
    
    private func filterUsers(serviceUsers : [ServiceUser]){
        for serviceUser in serviceUsers{
            switch serviceUser.userRole.lowercased() {
            case ServiceUserRole.lawyer:
                let lawyer = ServiceUserViewModel(serviceUser: serviceUser)
                serviceLawyersList.append(lawyer)
            case ServiceUserRole.interiorDesigner.lowercased():
                let interiorDesigner = ServiceUserViewModel(serviceUser: serviceUser)
                serviceInteriorDesignersList.append(interiorDesigner)
            default: break
            }
        }
    }
}
