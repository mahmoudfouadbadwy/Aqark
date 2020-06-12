//
//  AdminUsersViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class AdminUsersViewController: UIViewController{
    
 
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var usersSearchBar: UISearchBar!
    @IBOutlet weak var usersSegment: CustomSegment!
    @IBOutlet weak var usersTableView: UITableView!
    
    var adminUsersViewModel : AdminUsersListViewModel!
    private var dataAccess : AdminDataAccess!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dataAccess = AdminDataAccess()
        adminUsersViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
        if(adminUsersViewModel.checkNetworkConnection()){
            setupUsersTable()
            usersSearchBar.delegate = self
            bindUsersTable()
        }else{
            setupNoConnection()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Users"
    }
    
    private func setupView() {
        usersSegment.backgroundColor = UIColor(rgb: 0xf1faee)
        usersSearchBar.backgroundColor = UIColor(rgb: 0xf1faee)
        usersSearchBar.barTintColor = UIColor(rgb: 0xf1faee)
        usersTableView.backgroundColor = UIColor(rgb: 0xf1faee)
        view.backgroundColor = UIColor(rgb: 0xf1faee)
        view.alpha = 0.5
    }
    
    private func setupUsersTable() {
        usersTableView.register(UINib(nibName: "AdminUserTableViewCell", bundle: nil), forCellReuseIdentifier: "User Cell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    private func setupNoConnection() {
        view.alpha = 0
        noLabel.isHidden = false
        noLabel.text = "Internet Connection Not Available."
    }
    
    private func bindUsersTable() {
        showActivityIndicator()
        adminUsersViewModel.populateUsers {
            UIView.animate(withDuration:2) {
                self.view.alpha = 1
            }
            self.stopActivityIndicator()
            if(self.adminUsersViewModel.adminUsersViewList.isEmpty){
                self.setLabelForZeroCount(search: false)
            }else{
                self.usersSearchBar.isHidden = false
                self.usersTableView.reloadData()
            }
        }
    }
    
    func setLabelForZeroCount(search:Bool){
        usersSearchBar.isHidden = !search
        noLabel.isHidden = false
        switch usersSegment.selectedIndex {
        case 0:
            noLabel.text = "No Users Available."
        case 1:
            noLabel.text = "No Lawyers Available."
        default:
            noLabel.text = "No Interior Designers Available."
        }
    }
    
    func showAlert(title:String,message:String){
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
               alert.dismiss(animated: true, completion: nil)}
           alert.addAction(okAction)
           self.present(alert, animated: true, completion: nil)
       }
    
    @IBAction func changeUserType(_ sender: Any) {
        adminUsersViewModel.getUsersByType(type: usersSegment.selectedIndex)
        if(self.adminUsersViewModel.adminUsersViewList.isEmpty){
            self.setLabelForZeroCount(search: false)
        }else{
            usersSearchBar.isHidden = false
            noLabel.isHidden = true
        }
        self.usersTableView.reloadData()
    }
}


