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
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func goToAddAdvertisement()
    {
        self.navigationController?.pushViewController(AddAdvertisementViewController(), animated: true)
    }
}

