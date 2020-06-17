//
//  SignUpUI.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK: - setup views
extension SignUpView{
    func setupViews(as role:String)
    {
        haveAccount.textColor = UIColor(rgb: 0x1d3557)
        switch (self.role.lowercased())
        {
        case "user": showUserView()
        default: print("")
        }
    }
    
   func setIcons()
    {
         self.username.setIcon(UIImage(named: "profile")!)
         self.email.setIcon(UIImage(named: "Email")!)
         self.password.setIcon(UIImage(named: "password")!)
         self.confirmPassword.setIcon(UIImage(named: "password")!)
         self.phoneNumber.setIcon(UIImage(named: "phone")!)
         self.company.setIcon(UIImage(named: "company")!)
         self.address.setIcon(UIImage(named: "profile_map")!)
    }
    func showUserView()
    {
        self.phoneNumber.isHidden = true
        self.address.isHidden = true
        self.company.isHidden = true
        self.governmantHint.isHidden = true
    }
}

//MARK: - TextFiled Delegate
extension SignUpView:UITextFieldDelegate{
    func setTextFieldsDelegate()
    {
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        username.delegate = self
        phoneNumber.delegate = self
        company.delegate = self
        address.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
