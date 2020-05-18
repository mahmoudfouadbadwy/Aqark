//
//  AdminUsersViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminUsersViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    private var adminUsersListViewModel : AdminUsersListViewModel!
    private var dataAccess : AdminDataAccessLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.register(UINib(nibName: "AdminUserTableViewCell", bundle: nil), forCellReuseIdentifier: "User Cell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
        dataAccess = AdminDataAccessLayer()
        adminUsersListViewModel = AdminUsersListViewModel(dataAccess: dataAccess)
        adminUsersListViewModel.populateUsers {
            print(self.adminUsersListViewModel.adminUsersList.count)
            print(self.adminUsersListViewModel.adminLawyersList.count)
            print(self.adminUsersListViewModel.adminInteriorDesignersList.count)
            self.usersTableView.reloadData()
        }
    }
}

extension AdminUsersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adminUsersListViewModel.adminUsersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = usersTableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath) as? AdminUserTableViewCell
        userCell?.userName.text = adminUsersListViewModel.adminUsersList[indexPath.row].userName
        let userImageURL = URL(string: adminUsersListViewModel.adminUsersList[indexPath.row].userImage)
        do{
            let userImageData = try Data(contentsOf: userImageURL!)
            let userImage = UIImage(data: userImageData)
            userCell?.userImage.image = userImage
        }catch{
            let userImagePlaeHolder = UIImage(named: "signup_company")
            userCell?.userImage.image = userImagePlaeHolder
        }
        return userCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return usersTableView.frame.height / 5.0
    }
    
    
}
