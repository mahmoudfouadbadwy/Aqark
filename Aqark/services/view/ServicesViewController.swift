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
    @IBOutlet weak var noLabel: UILabel!
    var servicesViewModel : ServicesListViewModel!
    var dataAccess : ServiceDataAccess!
    var serviceRole : String!
    var advertisementCountry : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAccess = ServiceDataAccess()
        servicesViewModel = ServicesListViewModel(dataAccess: dataAccess)
        view.backgroundColor = UIColor(rgb: 0xf1faee)
        servicesCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
        if(servicesViewModel.checkNetworkConnection()){
            showActivityIndicator()
            self.view.alpha = 0
            navigationItem.title = serviceRole
            let servicesNib = UINib(nibName: "ServicesCollectionViewCell", bundle: nil)
            servicesCollectionView.register(servicesNib, forCellWithReuseIdentifier: "Service Cell")
            servicesCollectionView.delegate = self
            servicesCollectionView.dataSource = self
            print("serviceRole : " , serviceRole)
            print("advertisemnt country : " , advertisementCountry)
            
            servicesViewModel.getServiceUsers {
                self.servicesViewModel.getServiceUsersList(serviceUserRole: self.serviceRole.localize, country: self.advertisementCountry.localize)
                self.stopActivityIndicator()
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
            noLabel.text = "Internet Connection Not Available".localize
        }
    }
    
    private func setLabelForZeroCount(){
        noLabel.isHidden = false
        if(serviceRole == "Lawyers".localize){
            noLabel.text = "No Lawyers Available.".localize
        }else{
            noLabel.text = "No Interior Designers Available.".localize
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
        serviceCell.serviceUserLocation.text = servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserCountry.localize
        if "lang".localize.elementsEqual("en")
        {
            serviceCell.serviceUserExperience.text = self.convertNumbers(lang: "lang".localize, stringNumber: servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserExperience).1 + " years exp".localize
        }else{
            let numberOfExp = self.convertNumbers(lang: "lang".localize, stringNumber: servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserExperience).0.intValue
            if numberOfExp == 0 {
                serviceCell.serviceUserExperience.text = ""
            }
            else if numberOfExp == 1{

                serviceCell.serviceUserExperience.text = "سنه خبره"
            }else if numberOfExp == 2{

                serviceCell.serviceUserExperience.text = "سنتين خبره"
            }else{

                serviceCell.serviceUserExperience.text = self.convertNumbers(lang: "lang".localize, stringNumber: String(numberOfExp)).1 + " years exp".localize
            }
        }
        
                  serviceCell.serviceUserRating.rating =
                      servicesViewModel.serviceUsersViewList[indexPath.row].serviceUserServiceRating
                  let serviceUserImageURL = URL(string: servicesViewModel.serviceUsersViewList[indexPath.row].ServiceUserImage)
                  serviceCell.serviceUserImage.sd_setImage(with:serviceUserImageURL , placeholderImage: UIImage(named: "profile_user"))
                  return serviceCell
    }
}

extension ServicesViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30, height: 190)
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
            showAlert(title:"Error".localize ,message:"You can't rate yourself".localize)
            return true
        }
        return false
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok".localize, style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
