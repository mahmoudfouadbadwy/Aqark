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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var noLabel: UILabel!
    var servicesViewModel : ServicesListViewModel!
    var dataAccess : ServiceDataAccess!
    var serviceRole : String!
    var advertisementCountry : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAccess = ServiceDataAccess()
        servicesViewModel = ServicesListViewModel(dataAccess: dataAccess)
        if(servicesViewModel.checkNetworkConnection()){
            activityIndicator.startAnimating()
            self.view.alpha = 0
            navigationItem.title = serviceRole
            let servicesNib = UINib(nibName: "ServicesCollectionViewCell", bundle: nil)
            servicesCollectionView.register(servicesNib, forCellWithReuseIdentifier: "Service Cell")
            servicesCollectionView.delegate = self
            servicesCollectionView.dataSource = self
            servicesViewModel.getServiceUsers {
                self.servicesViewModel.getServiceUsersList(serviceUserRole: self.serviceRole, country: self.advertisementCountry)
                self.activityIndicator.stopAnimating()
                UIView.animate(withDuration:2) {
                    self.view.alpha = 1
                }
                if(self.servicesViewModel.serviceUsersViewList.isEmpty){
                    self.setLabelForZeroCount()
                }else{
                    self.servicesCollectionView.reloadData()
                }
            }
        }else{
            noLabel.isHidden = false
            noLabel.text = "No Internet Connection."
        }
    }
    
    private func setLabelForZeroCount(){
        noLabel.isHidden = false
        if(serviceRole == "Lawyers"){
            noLabel.text = "No Available Lawyers."
        }else{
            noLabel.text = "No Available Interior Designers."
        }
    }
}

extension ServicesViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.servicesViewModel.serviceUsersViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let serviceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Service Cell", for: indexPath) as! ServicesCollectionViewCell
                  serviceCell.serviceUserCellIndex = indexPath
                  serviceCell.serviceUserDelegate = self
                  serviceCell.serviceUserName.text = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserName
                  serviceCell.serviceUserCompany.text = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserCompany
                  serviceCell.serviceUserLocation.text = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserCountry
                  serviceCell.serviceUserExperience.text =
                      servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserExperience
                  serviceCell.serviceUserRating.rating =
                      servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserServiceRating
                  let serviceUserImageURL = URL(string: servicesViewModel.serviceUsersViewList[indexPath.row].ServiceUserImage)
                  serviceCell.serviceUserImage.sd_setImage(with:serviceUserImageURL , placeholderImage: UIImage(named: "profile_user"))
                  return serviceCell
    }
}

extension ServicesViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width - 40, height: 190)
    }
}

extension ServicesViewController:ServiceUsersCollectionDelegate{
    func checkLoggedUserDelegate() -> Bool {
       return  servicesViewModel.checkLoggedUser()
    }
    
    
    func rateServiceUserDelegate(at indexPath: IndexPath,rate : Double) {
        let serviceUserId = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserId
        servicesViewModel.rateUserService(rate: rate, serviceUserId: serviceUserId)
    }
    
    func checkServiceUserDelegate(at indexPath: IndexPath) -> Bool{
        let serviceUserId = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserId
        let sameUser = servicesViewModel.checkServiceUser(serviceUserId: serviceUserId)
        if(sameUser){
            showAlert(title:"User Error",message:"You can't rate yourself")
            return true
        }
        return false
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
