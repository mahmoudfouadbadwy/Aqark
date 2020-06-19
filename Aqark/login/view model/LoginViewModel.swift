//
//  LoginViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/13/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
import ReachabilitySwift


class LoginViewModel : ValidationProtocol{
    
    var userEmail : String!
    var userPassword : String!
    var brokenRules: [LoginBrokenRule] = [LoginBrokenRule]()
    var dataAccess : LoginDataAccessLayer!
    var isValid: Bool {
        get{
            self.brokenRules.removeAll()
            self.validate()
            return brokenRules.count == 0
        }
    }
    
    init(dataAccess:LoginDataAccessLayer) {
        self.dataAccess = dataAccess
    }
    
    func validate(){
        if(!(userEmail.isEmpty)){
            if(!(isValidEmail(email: userEmail))){
                self.brokenRules.append(LoginBrokenRule(propertyName: "User Email".localize, message: "The email or password you entered is invalid".localize))
            }
        }else{
            self.brokenRules.append(LoginBrokenRule(propertyName: "User Email".localize, message: "An email address must be provided.".localize))
        }
        
        if(!(userPassword.isEmpty)){
            if(userPassword.count < 6){
                self.brokenRules.append(LoginBrokenRule(propertyName: "User Password".localize, message: "The email or password you entered is invalid".localize))
            }
        }else{
            self.brokenRules.append(LoginBrokenRule(propertyName: "User password".localize, message: "The password must be 6 characters long or more.".localize))
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func authenticateLogin(completion:@escaping(_ result:String?,_ error :String?)->Void){
        dataAccess.login(userEmail: userEmail, userPassword: userPassword) { (result,error) in
            
            if let error = error {
                completion(nil,error)
            }else{
                completion(result,nil)
            }
        }
    }
    
    func resetPassword(userEmail:String,completionForResetPassword:@escaping(_ completed:Bool) -> Void){
        dataAccess.resetPassword(userEmail: userEmail) { (completed) in
                completionForResetPassword(completed)
        }
    }
    
    func checkNetworkConnection()->Bool{
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
    
    func isAdminLogged() -> Bool{
        return Auth.auth().currentUser?.email == "aqark@admin.com"
    }
}

