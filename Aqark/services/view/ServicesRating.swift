//
//  ServicesRating.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension ServicesViewController:ServiceUsersCollectionDelegate{
    
    func checkLoggedUserDelegate() -> Bool {
        return  servicesViewModel.checkLoggedUser()
    }
    
    
    func rateServiceUserDelegate(at indexPath: IndexPath,rate : Double) {
        let serviceUserId = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserId
        servicesViewModel.rateUserService(rate: rate, serviceUserId: serviceUserId)
    }
    
    func checkServiceUserDelegate(at indexPath: IndexPath) -> Bool{
        let serviceUserId = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserId
        let sameUser = servicesViewModel.checkServiceUser(serviceUserId: serviceUserId)
        if(sameUser){
            showAlert(title:"Error".localize ,message:"You can't rate yourself".localize)
            return true
        }
        return false
    }
    
    func callServiceUser(at indexPath: IndexPath) {
        if let phone = URL(string: ("tel://" + self.servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserPhone)){
            let name = self.servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserName
            showCallAlert(phone:phone,name:name)
        }
    }
    
    func showCallAlert(phone:URL,name:String)
      {
          let alert = UIAlertController(title: "Call".localize, message: "Are You Sure You Want To \(name)?".localize, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Call".localize, style: .default, handler: { (action) in
              UIApplication.shared.open(phone,options:[:],completionHandler: nil)
          }))
          alert.addAction(UIAlertAction(title: "Cancel".localize, style: .cancel, handler: nil))
          self.present(alert, animated: true)
      }
}
