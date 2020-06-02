//
//  CreateAccount.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
//MARK: - create Account
extension SignUpView{
    func createUserAccount(email:String,password:String,confirm:String,username:String)
    {
        accountViewModel = AccountViewModel(email: email, password: password, confirmPassword: confirm, username: username)
        checkValidation()
    }
    func createServiceAccount(email:String,password:String,confirm:String,username:String,
                              phone:String,country:String,company:String){
        accountViewModel = AccountViewModel(email: email, password: password, confirmPassword: confirm, username: username, phone: phone, country: country, company: company,role:role)
        checkValidation()
    }
    
    func checkValidation()
    {
        if (accountViewModel.isValid)
        {
            showActivityIndicator()
            accountViewModel.performCreation(dataAccess: SignUpDataAccess(),completion: {
                (result) in
                self.stopActivityIndicator()
                self.gotoProfileView()
            })
        }
        else
        {
            self.showAlert(with: accountViewModel.brokenRules[0].message)
        }
    }
    
    func gotoProfileView()
    {
        let profileView:ProfileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileView, animated: true)
    }
}
