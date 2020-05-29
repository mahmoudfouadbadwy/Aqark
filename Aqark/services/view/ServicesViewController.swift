//
//  ServicesViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var servicesCollectionView: UICollectionView!
    var servicesViewModel : ServicesListViewModel!
    var dataAccess : ServiceDataAccess!
    var serviceRole : String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let servicesNib = UINib(nibName: "ServicesCollectionViewCell", bundle: nil)
        servicesCollectionView.register(servicesNib, forCellWithReuseIdentifier: "Service Cell")
        dataAccess = ServiceDataAccess()
        servicesViewModel = ServicesListViewModel(dataAccess: dataAccess)
        servicesViewModel.getServiceUsers {
            print(self.servicesViewModel.serviceLawyersList.count)
            print(self.servicesViewModel.serviceInteriorDesignersList.count)
            self.servicesViewModel.getServiceUsersList(serviceUserRole: self.serviceRole)
            print(self.servicesViewModel.serviceUsersViewList.count)
        }
        
    }
}
