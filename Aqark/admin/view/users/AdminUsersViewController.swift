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
    @IBOutlet weak var totalUsersLabel: UILabel!
    @IBOutlet weak var userRoleNumberLabel: UILabel!
    
    var adminUsersViewModel : AdminUsersListViewModel!
    private var dataAccess : AdminDataAccess!
    var isDisappearing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersSearchBar.delegate = self
        setupView()
        setupUsersTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Users"
        if(AdminNetworking.checkNetworkConnection()){
            view.alpha = 0.5
            totalUsersLabel.isHidden = true
            userRoleNumberLabel.isHidden = true
            dataAccess = AdminDataAccess()
            adminUsersViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
            isDisappearing =  false
            bindUsersTable()
        }else{
            setupNoConnection()
        }
    }
    
    private func setupView() {
        usersSegment.backgroundColor = UIColor(rgb: 0xf1faee)
        usersSearchBar.backgroundColor = UIColor(rgb: 0xf1faee)
        usersSearchBar.barTintColor = UIColor(rgb: 0xf1faee)
        usersTableView.backgroundColor = UIColor(rgb: 0xf1faee)
        view.backgroundColor = UIColor(rgb: 0xf1faee)
    }
    
    private func setupUsersTable() {
        usersTableView.register(UINib(nibName: "AdminUserTableViewCell", bundle: nil), forCellReuseIdentifier: "User Cell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    private func setupNoConnection() {
        view.alpha = 1
        noLabel.isHidden = false
        usersSearchBar.isHidden = true
        totalUsersLabel.isHidden = true
        userRoleNumberLabel.isHidden = true
        noLabel.text = "Internet Connection Not Available."
    }
    
    private func bindUsersTable() {
        noLabel.isHidden = true
        showActivityIndicator()
        adminUsersViewModel.populateUsers { [weak self] (totalUsers) in
            UIView.animate(withDuration:2) {
                self?.view.alpha = 1
            }
            self?.totalUsersLabel.isHidden = false
            self?.totalUsersLabel.text = "Total Users: \(totalUsers)"
            self?.stopActivityIndicator()
            self?.adminUsersViewModel.getUsersByType(type: self!.usersSegment.selectedIndex)
            if(!self!.adminUsersViewModel.adminUsersViewList.isEmpty){
                if(!self!.usersSearchBar.text!.isEmpty){
                    self?.adminUsersViewModel.getFilteredUsers(type: self!.usersSegment.selectedIndex, searchText: self!.usersSearchBar.text!)
                    if(self!.adminUsersViewModel.adminUsersViewList.isEmpty){
                        self?.setLabelForZeroCount(search: true)
                    }else{
                        self?.noLabel.isHidden = true
                    }
                }
                self?.usersSearchBar.isHidden = false
                self?.noLabel.isHidden = true
                //self?.usersSearchBar.text = ""
            }else{
                self?.setLabelForZeroCount(search: false)
            }
            self?.setUserRoleLabel()
            self?.usersTableView.reloadData()
        }
    }
    
    func setLabelForZeroCount(search:Bool){
        usersSearchBar.isHidden = !search
        noLabel.isHidden = false
        if(AdminNetworking.checkNetworkConnection()){
            switch usersSegment.selectedIndex {
            case 0:
                noLabel.text = "No Users Available."
            case 1:
                noLabel.text = "No Lawyers Available."
            default:
                noLabel.text = "No Interior Designers Available."
            }
        }else{
            setupNoConnection()
        }
        
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeUserType(_ sender: Any) {
        if(adminUsersViewModel == nil && AdminNetworking.checkNetworkConnection()){
            totalUsersLabel.isHidden = true
            userRoleNumberLabel.isHidden = true
            dataAccess = AdminDataAccess()
            adminUsersViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
            isDisappearing =  false
            bindUsersTable()
        }
        
        if(adminUsersViewModel != nil){
            usersSearchBar.text = ""
            adminUsersViewModel.getUsersByType(type: usersSegment.selectedIndex)
            if(adminUsersViewModel.adminUsersViewList.isEmpty){
                setLabelForZeroCount(search: false)
            }else{
                usersSearchBar.isHidden = false
                noLabel.isHidden = true
            }
            totalUsersLabel.isHidden = false
            setUserRoleLabel()
            usersTableView.reloadData()
        }
        
        if(adminUsersViewModel == nil && !AdminNetworking.checkNetworkConnection()){
            setupNoConnection()
        }
    }
    
    func setUserRoleLabel(){
        userRoleNumberLabel.isHidden = false
        switch usersSegment.selectedIndex{
        case 0:
            userRoleNumberLabel.text = "Agents: \(adminUsersViewModel.adminUsersViewList.count)"
        case 1:
            userRoleNumberLabel.text = "Lawyers: \(adminUsersViewModel.adminUsersViewList.count)"
        default:
            userRoleNumberLabel.text = "Designers: \(adminUsersViewModel.adminUsersViewList.count)"
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isDisappearing = true
        if adminUsersViewModel != nil {
            adminUsersViewModel.removeUserObservers()
            adminUsersViewModel.adminUsersViewList.removeAll()
            usersTableView.reloadData()
        }
        dataAccess = nil
        adminUsersViewModel = nil
    }
    
    deinit {
        print("Admin Users deinit")
    }
}


