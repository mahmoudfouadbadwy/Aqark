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
        let logout = UIBarButtonItem(title : "Logout",style: .done, target: self, action: #selector(self.logout(sender:)))
        logout.tintColor = UIColor(rgb: 0x1d3557)
        self.navigationItem.leftBarButtonItem = logout
    }
        
    func setupTabBarController(){
        let adminUserViewController = AdminUsersViewController()
        let adminAdvertisementViewController = AdminAdvertisementsViewController()
        let adminReportsView = AdminReportsView()
        tabBar.tintColor = UIColor(rgb: 0xe63946)
        tabBar.barTintColor = UIColor(rgb: 0xf1faee)
        adminUserViewController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        adminAdvertisementViewController.tabBarItem = UITabBarItem(title: "Advertisements", image: UIImage(named: "propertyType"), selectedImage: UIImage(named: "propertyType"))
        adminReportsView.tabBarItem = UITabBarItem(title: "Reports", image: UIImage(named: "report"), tag: 3)
        self.viewControllers = [adminUserViewController,adminAdvertisementViewController,adminReportsView]
    }
    
    @objc func logout(sender:UIBarButtonItem){
        adminUsersViewModel.logout(){(signOutError) in
            if let signOutError = signOutError{
                self.showAlert(title: "Signout", message: signOutError)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
