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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddAdvertisement))
        self.navigationItem.hidesBackButton = true
        let logout = UIBarButtonItem(title: "logout".localize,style: .done, target: self, action: #selector(self.logout(sender:)))
        self.navigationItem.leftBarButtonItem = logout
        
        
    }
    @objc func logout(sender: UIBarButtonItem){
        let profileViewModel:ProfileStore = ProfileStore(by: profileDataAccess)
        profileViewModel.logout()
        
        self.navigationController?.pushViewController(FirstScreenViewController(), animated: true)
    }
    @objc func goToAddAdvertisement()
    {
        if self.ban
        {
            showAlert(title:"Bolcking".localize,message:"You Are Blocked From Adding Advertisements".localize)
        }
        else
        {
            self.navigationController?.pushViewController(AddAdvertisementViewController(), animated: true)
        }
        
    }
    
    @IBAction func editProfileBtn(_ sender: Any) {
        if ProfileNetworking.checkNetworkConnection(){
            let editViewController = EditProfileViewController()
            navigationController?.pushViewController(editViewController, animated: true)
        }else{
            showAlert(title:"Internet Connection".localize,message:"Internet Connection Not Available".localize)
        }
    }
    
    
    private func showAlert(title:String,message:String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok".localize, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

