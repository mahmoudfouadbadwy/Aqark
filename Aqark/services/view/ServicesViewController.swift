//
//  ServicesViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import SDWebImage

class ServicesViewController: UIViewController {

    @IBOutlet weak var servicesCollectionView: UICollectionView!
    var servicesViewModel : ServicesListViewModel!
    var dataAccess : ServiceDataAccess!
    var serviceRole : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let servicesNib = UINib(nibName: "ServicesCollectionViewCell", bundle: nil)
        servicesCollectionView.register(servicesNib, forCellWithReuseIdentifier: "Service Cell")
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        dataAccess = ServiceDataAccess()
        servicesViewModel = ServicesListViewModel(dataAccess: dataAccess)
        servicesViewModel.getServiceUsers {
            self.servicesViewModel.getServiceUsersList(serviceUserRole: self.serviceRole)
            self.servicesCollectionView.reloadData()
        }
    }
}

extension ServicesViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.servicesViewModel.serviceUsersViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let serviceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Service Cell", for: indexPath) as! ServicesCollectionViewCell
        serviceCell.serviceUserName.text = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserName
        serviceCell.serviceUserCompany.text = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserCompany
        serviceCell.serviceUserLocation.text = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserCountry
        serviceCell.serviceUserExperience.text =
            servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserExperience
        serviceCell.serviceUserRating.rating =
            servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserServiceRating
        let serviceUserImageURL = URL(string: servicesViewModel.serviceUsersViewList[indexPath.row].ServiceUserImage)
        serviceCell.serviceUserImage.sd_setImage(with:serviceUserImageURL , placeholderImage: UIImage(named: "signup_company"))
        return serviceCell
    }
}

extension ServicesViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width - 30 , height: collectionView.frame.height/3);
       }
}
