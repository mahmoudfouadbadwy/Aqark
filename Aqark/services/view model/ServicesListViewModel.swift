//
//  ServiceUsersListViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

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
    
    func getServiceUsersList(serviceUserRole : String,country : String){
        if(serviceUserRole.elementsEqual("Lawyers".localize)){
            serviceUsersViewList = serviceLawyersList.filter({ (lawyer) -> Bool in
                getGovernorate(lawyer.serviceUserCountry).localize == country
            })
        }else{
            serviceUsersViewList = serviceInteriorDesignersList.filter({ (interiorDesigner) -> Bool in
                getGovernorate(interiorDesigner.serviceUserCountry).localize == country
            })
        }
    }
    
    func rateUserService(rate:Double,serviceUserId:String){
        if let loggedUserId = Auth.auth().currentUser?.uid{
            let approximateRate = round(1000.0 * rate)/1000.0
            dataAccess?.rateServiceUser(rate: approximateRate, userId: loggedUserId, serviceUserId: serviceUserId)
        }
    }
    
    func checkServiceUser(serviceUserId:String) -> Bool{
        if(serviceUserId == Auth.auth().currentUser?.uid){
            return true
        }else{
            return false
        }
    }
    
    func checkLoggedUser() -> Bool{
        if (Auth.auth().currentUser?.uid) != nil{
            return true
        }else{
            return false
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
    
    func removeServicesObservers(){
        dataAccess?.removeServicesObservers()
        dataAccess = nil
    }
    
    func getGovernorate(_ country:String) -> String{
         if(country.contains(",")){
            let governorate = country.components(separatedBy: ",").count - 2
            return country.components(separatedBy: ",")[governorate]
         }else{
             return country
         }
     }
}
