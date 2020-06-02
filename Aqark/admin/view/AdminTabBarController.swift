//
//  AdminTabBarController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminTabBarController: UITabBarController {
    
    var adminUsersViewModel : AdminUsersListViewModel!
    var dataAccess : AdminDataAccess!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAccess = AdminDataAccess()
        adminUsersViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
        setupTabBarController()
        self.navigationItem.hidesBackButton = true
        let logout = UIBarButtonItem(image: UIImage(named: "logout"),style: .done, target: self, action: #selector(self.logout(sender:)))
        self.navigationItem.leftBarButtonItem = logout
    }
    
    func setupTabBarController(){
        let adminUserViewController = AdminUsersViewController()
        let adminAdvertisementViewController = AdminAdvertisementsViewController()
        let adminReportsView = AdminReportsView()
        adminUserViewController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "signup_company"), selectedImage: UIImage(named: "signup_company"))
        adminAdvertisementViewController.tabBarItem = UITabBarItem(title: "Advertisements", image: UIImage(named: "signup_company"), selectedImage: UIImage(named: "signup_company"))
        adminReportsView.tabBarItem = UITabBarItem(title: "Reports", image: UIImage(named: "PropertyDetail_feedback"), tag: 3)
        self.viewControllers = [adminUserViewController,adminAdvertisementViewController,adminReportsView]
    }
    
    @objc func logout(sender:UIBarButtonItem){
        adminUsersViewModel.logout()
        self.navigationController?.popViewController(animated: true)
    }
}
