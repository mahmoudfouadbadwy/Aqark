//
//  ProfileNavigationProperties.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK: - Navigation Properties
extension ProfileViewController{
    func setNavigationProperties()
    {
        self.navigationItem.title = "Profile".localize
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editProfileBtn))
        self.navigationItem.hidesBackButton = true
        logout = UIBarButtonItem(title: "logout".localize,style: .done, target: self, action: #selector(self.logout(sender:)))
        self.navigationItem.leftBarButtonItem = logout
        
    }
    @objc func logout(sender: UIBarButtonItem){
        if profileViewModel !=  nil
        {
            profileViewModel.logout()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc  func editProfileBtn() {
        if ProfileNetworking.checkNetworkConnection(){
            editViewController = EditProfileViewController()
            navigationController?.pushViewController(editViewController, animated: true)
        }else{
            showAlert(title:"Internet Connection".localize,message:"Internet Connection Not Available".localize)
        }
    }
    
    
    func showAlert(title:String,message:String)
    {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertAction = UIAlertAction(title: "Ok".localize, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

