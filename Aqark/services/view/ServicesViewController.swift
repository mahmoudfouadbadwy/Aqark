//
//  ServicesViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import SDWebImage

class ServicesViewController: UIViewController{
    
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var noLabel: UILabel!
    
    var servicesViewModel : ServicesListViewModel!
    var dataAccess : ServiceDataAccess!
    var serviceRole : String!
    var advertisementCountry : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupServicesCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(ServicesNetworking.checkNetworkConnection()){
               dataAccess = ServiceDataAccess()
               servicesViewModel = ServicesListViewModel(dataAccess: dataAccess)
               bindServicesCollection()
           }else{
               setupNoConnectionView()
           }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(rgb: 0xf1faee)
        servicesCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
        view.alpha = 0.5
        navigationItem.title = serviceRole
    }
    
    private func setupNoConnectionView() {
        noLabel.isHidden = false
        noLabel.text = "Internet Connection Not Available".localize
    }
    
    private func setLabelForZeroCount(){
        noLabel.isHidden = false
        if(serviceRole == "Lawyers".localize){
            noLabel.text = "No Lawyers Available.".localize
        }else{
            noLabel.text = "No Interior Designers Available.".localize
        }
    }
    
    private func setupServicesCollection() {
        showActivityIndicator()
        let servicesNib = UINib(nibName: "ServicesCollectionViewCell", bundle: nil)
        servicesCollectionView.register(servicesNib, forCellWithReuseIdentifier: "Service Cell")
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
    }
    
    private func bindServicesCollection() {
        servicesViewModel.getServiceUsers {[weak self] in
            self?.servicesViewModel.getServiceUsersList(serviceUserRole: self!.serviceRole.localize, country: self!.advertisementCountry.localize)
            self?.stopActivityIndicator()
            UIView.animate(withDuration:2) {
                self?.view.alpha = 1
            }
            if(self!.servicesViewModel.serviceUsersViewList.isEmpty){
                self?.setLabelForZeroCount()
            }else{
                self?.servicesCollectionView.reloadData()
            }
        }
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok".localize, style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func splitCountry(_ country:String) -> String{
           if(country.contains(",")){
               return country.components(separatedBy: ",")[1]
           }else{
               return country
           }
       }
    
    deinit {
        if servicesViewModel != nil{
            servicesViewModel.removeServicesObservers()
        }
        dataAccess = nil
        servicesViewModel = nil 
        print("Services deinit")
    }
}
