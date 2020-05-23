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
    private var adminUsersListViewModel : AdminUsersListViewModel!
    private var dataAccess : AdminDataAccessLayer!
    private var selectedUserIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.register(UINib(nibName: "AdminUserTableViewCell", bundle: nil), forCellReuseIdentifier: "User Cell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersSearchBar.delegate = self
        dataAccess = AdminDataAccessLayer()
        adminUsersListViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
        adminUsersListViewModel.populateUsers {
            print(self.adminUsersListViewModel.adminUsersList.count)
            print(self.adminUsersListViewModel.adminLawyersList.count)
            print(self.adminUsersListViewModel.adminInteriorDesignersList.count)
            self.usersTableView.reloadData()
        }
    }
    

    @IBAction func changeUserType(_ sender: Any) {
        adminUsersListViewModel.getUsersByType(type: usersSegment.selectedIndex)
           self.usersTableView.reloadData()
    }
}

extension AdminUsersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminUsersListViewModel.adminUsersViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = usersTableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath) as? AdminUserTableViewCell
        userCell?.userName.text = adminUsersListViewModel.adminUsersViewList[indexPath.row].userName
        userCell?.userRating.rating = adminUsersListViewModel.adminUsersViewList[indexPath.row].userRating.toDouble() ?? 0.0
        let userImageURL = URL(string: adminUsersListViewModel.adminUsersViewList[indexPath.row].userImage)
        userCell?.userImage.sd_setImage(with: userImageURL, placeholderImage: UIImage(named: "signup_company"))
        return userCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return usersTableView.frame.height / 7.0
    }
    
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}


extension AdminUsersViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        adminUsersListViewModel.getFilteredUsers(type: usersSegment.selectedIndex, searchText: searchText)
        usersTableView.reloadData()
    }
}

