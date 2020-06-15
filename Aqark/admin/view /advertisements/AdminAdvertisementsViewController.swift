//
//  AdminAdvertisementsViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminAdvertisementsViewController: UIViewController,AdminAdvertisementsReportDelegate {
    
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var advertisementsCollectionView: UICollectionView!
    @IBOutlet weak var advertisementsSearchBar: UISearchBar!
    
    var adminAdvertisementViewModel : AdminAdvertisementsListViewModel!
    private var dataAccess : AdminDataAccess!
    private var reportedAdvertisementId:String?
    var isDisappearing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAdvertisementsCollection()
        advertisementsSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Advertisements"
        if(AdminNetworking.checkNetworkConnection()){
            isDisappearing = false
            dataAccess = AdminDataAccess()
            adminAdvertisementViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
            if let reportedAdvertisementId = reportedAdvertisementId{
                getReportedAdvertisement(reportedAdvertisementId)
            }else{
                bindAdvertisementsCollection()
            }
        }else{
            setupNoConnection()
        }
    }
    
    private func setupViews() {
        advertisementsSearchBar.backgroundColor = UIColor(rgb: 0xf1faee)
        advertisementsSearchBar.barTintColor = UIColor(rgb: 0xf1faee)
        advertisementsCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
        view.backgroundColor = UIColor(rgb: 0xf1faee)
        view.alpha = 0.5
    }
    
    private func setupAdvertisementsCollection() {
        advertisementsCollectionView.register(UINib(nibName: "AdminAdvertisementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Advertisement Cell")
        advertisementsCollectionView.delegate = self
        advertisementsCollectionView.dataSource = self
    }
    
    private func bindAdvertisementsCollection() {
        noLabel.isHidden = true
        showActivityIndicator()
        adminAdvertisementViewModel.populateAdvertisements {[weak self] in
            self?.stopActivityIndicator()
            UIView.animate(withDuration:2){
                self?.view.alpha = 1
            }
            if(!self!.adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                if(!self!.advertisementsSearchBar.text!.isEmpty){
                    self?.adminAdvertisementViewModel.getFilteredAdvertisements(searchText: self!.advertisementsSearchBar.text!)
                    if(self!.adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                        self?.setLabelForZeroCount(text: "No available advertisements")
                    }else{
                        self?.noLabel.isHidden = true
                    }
                }
                self?.advertisementsSearchBar.isHidden = false
            }else{
                self?.setLabelForZeroCount(text: "No available advertisements")
                self?.advertisementsSearchBar.isHidden = true
            }
            self?.advertisementsCollectionView.reloadData()
        }
    }
    
    private func setupNoConnection() {
        noLabel.isHidden = false
        noLabel.text = "Internet Connection Not Available"
        advertisementsSearchBar.isHidden = true
    }
    
    private func getReportedAdvertisement(_ reportedAdvertisementId: String) {
        adminAdvertisementViewModel.getFilteredAdvertisements(searchText: reportedAdvertisementId)
        advertisementsCollectionView.reloadData()
        if(adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
            showAlert(title: "Advertisement", message: "Advertisement is deleted")
            adminAdvertisementViewModel.getFilteredAdvertisements(searchText: "")
        }else{
            advertisementsSearchBar.text = reportedAdvertisementId
        }
        self.reportedAdvertisementId = nil
    }
    
    func getSelectedAdvertisement(advertisementId: String) {
        reportedAdvertisementId = advertisementId
    }
    
    func setLabelForZeroCount(text:String){
        noLabel.isHidden = false
        noLabel.text = text
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isDisappearing = true
        if adminAdvertisementViewModel != nil{
            adminAdvertisementViewModel.removeAdvertisementsObservers()
            adminAdvertisementViewModel.adminAdvertisementsViewList.removeAll()
            advertisementsCollectionView.reloadData()
        }
        dataAccess = nil
        adminAdvertisementViewModel = nil
    }
    
    deinit {
        print("Admin Advertisementd deinit")
    }
}


