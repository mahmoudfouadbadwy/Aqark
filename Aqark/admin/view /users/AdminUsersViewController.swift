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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var usersSearchBar: UISearchBar!
    
    @IBOutlet weak var usersSegment: CustomSegment!
    @IBOutlet weak var usersTableView: UITableView!
    private var adminUsersViewModel : AdminUsersListViewModel!
    private var dataAccess : AdminDataAccess!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAccess = AdminDataAccess()
        adminUsersViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
        usersSearchBar.isHidden = true
        usersSegment.isHidden = true
        if(adminUsersViewModel.checkNetworkConnection()){
            activityIndicator.startAnimating()
            self.view.alpha = 0
            
            usersTableView.register(UINib(nibName: "AdminUserTableViewCell", bundle: nil), forCellReuseIdentifier: "User Cell")
            usersTableView.delegate = self
            usersTableView.dataSource = self
            usersSearchBar.delegate = self

            adminUsersViewModel.populateUsers {
                self.activityIndicator.stopAnimating()
                UIView.animate(withDuration:2) {
                    self.view.alpha = 1
                }
                self.usersSegment.isHidden = false
                if(self.adminUsersViewModel.adminUsersViewList.isEmpty){

                    self.setLabelForZeroCount(search: false)

                }else{
                    self.usersSearchBar.isHidden = false
                    self.usersTableView.reloadData()
                }
            }
        }else{
            noLabel.isHidden = false
            noLabel.text = "No Internet Connection."
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Users"
        
    }
    
    private func setLabelForZeroCount(search:Bool){        usersSearchBar.isHidden = !search
        noLabel.isHidden = false

        switch usersSegment.selectedIndex {
        case 0:
            noLabel.text = "No Available Users."
        case 1:
            noLabel.text = "No Available Lawyers."
        default:
            noLabel.text = "No Available Interior Designers."
        }
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

extension AdminUsersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminUsersViewModel.adminUsersViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = usersTableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath) as? AdminUserTableViewCell
        userCell?.adminUserCellIndex = indexPath
        userCell?.adminUserDelegate = self
        userCell?.userName.text = adminUsersViewModel.adminUsersViewList[indexPath.row].userName
        userCell?.userRating.rating = adminUsersViewModel.adminUsersViewList[indexPath.row].userRating
        let userImageURL = URL(string: adminUsersViewModel.adminUsersViewList[indexPath.row].userImage)
        userCell?.userImage.sd_setImage(with: userImageURL, placeholderImage: UIImage(named: "profile_user"))
        userCell?.banUserButton.setTitle(adminUsersViewModel.adminUsersViewList[indexPath.row].isBanned ? "Unban" : "Ban", for: .normal)
        return userCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return usersTableView.frame.height / 4.0
    }
}

extension AdminUsersViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        adminUsersViewModel.getFilteredUsers(type: usersSegment.selectedIndex, searchText: searchText)
        usersTableView.reloadData()
        if(self.adminUsersViewModel.adminUsersViewList.isEmpty){
            self.setLabelForZeroCount(search: true)
        }else{
            noLabel.isHidden = true
        }
    }
}

extension AdminUsersViewController:AdminUsersDelegate{
    
    func checkBannedUser(at indexPath: IndexPath) -> Bool {
        return adminUsersViewModel.adminUsersViewList[indexPath.row].isBanned
    }
    
    func banUserDelegate(isBanned : Bool ,at indexPath: IndexPath) {
        let userId = adminUsersViewModel.adminUsersViewList[indexPath.row].userId
        adminUsersViewModel.banUser(isBanned: isBanned, userId: userId)
    }
}
