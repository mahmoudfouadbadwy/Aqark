//
//  AdminTabBarController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let adminUserViewController = AdminUsersViewController()
        let adminAdvertisementViewController = AdminAdvertisementsViewController()
        adminUserViewController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "signup_company"), selectedImage: UIImage(named: "signup_company"))
        adminAdvertisementViewController.tabBarItem = UITabBarItem(title: "Advertisements", image: UIImage(named: "signup_company"), selectedImage: UIImage(named: "signup_company"))
        self.viewControllers = [adminUserViewController,adminAdvertisementViewController]
    }
}
