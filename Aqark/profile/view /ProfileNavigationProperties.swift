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
        self.navigationItem.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddAdvertisement))
        self.navigationItem.hidesBackButton = true
        let logout = UIBarButtonItem(image: UIImage(named: "logout"),style: .done, target: self, action: #selector(self.logout(sender:)))
        self.navigationItem.leftBarButtonItem = logout
    }
    @objc func logout(sender: UIBarButtonItem){
       let profileViewModel:ProfileStore = ProfileStore(by: profileDataAccess)
        profileViewModel.logout()
        
        self.navigationController?.pushViewController(FirstScreenViewController(), animated: true)
    }
    @objc func goToAddAdvertisement()
    {
        self.navigationController?.pushViewController(AddAdvertisementViewController(), animated: true)
    }
    
    @IBAction func editProfileBtn(_ sender: Any) {
        if checkNetworkConnection(){
            let editViewController = EditProfileViewController()
            navigationController?.pushViewController(editViewController, animated: true)
        }else{
            let alertController = UIAlertController(title: "no Internet", message: "please check the internet connection", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

