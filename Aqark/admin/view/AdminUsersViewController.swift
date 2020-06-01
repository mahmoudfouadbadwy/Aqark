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
    
    @IBOutlet weak var usersSearchBar: UISearchBar!

    @IBOutlet weak var usersSegment: CustomSegment!
    @IBOutlet weak var usersTableView: UITableView!
    private var adminUsersViewModel : AdminUsersListViewModel!
    private var dataAccess : AdminDataAccess!
    private var selectedUserIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.register(UINib(nibName: "AdminUserTableViewCell", bundle: nil), forCellReuseIdentifier: "User Cell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersSearchBar.delegate = self
        self.navigationItem.title = "Users"
        dataAccess = AdminDataAccess()
        adminUsersViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
        adminUsersViewModel.populateUsers {
            self.usersTableView.reloadData()
            self.usersTableView.reloadData()
        }
    }
    

    @IBAction func changeUserType(_ sender: Any) {
        adminUsersViewModel.getUsersByType(type: usersSegment.selectedIndex)
           self.usersTableView.reloadData()
    }
}

extension AdminUsersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminUsersViewModel.adminUsersViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = usersTableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath) as? AdminUserTableViewCell
        userCell?.userName.text = adminUsersViewModel.adminUsersViewList[indexPath.row].userName
        userCell?.userRating.rating = adminUsersViewModel.adminUsersViewList[indexPath.row].userRating
        let userImageURL = URL(string: adminUsersViewModel.adminUsersViewList[indexPath.row].userImage)
        userCell?.userImage.sd_setImage(with: userImageURL, placeholderImage: UIImage(named: "signup_company"))
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
    }
}

