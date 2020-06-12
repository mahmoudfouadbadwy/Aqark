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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataAccess = AdminDataAccess()
        adminAdvertisementViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
        setupViews()
        if(adminAdvertisementViewModel.checkNetworkConnection()){
            setupAdvertisementsCollection()
            advertisementsSearchBar.delegate = self
            bindAdvertisementsCollection()
        }else{
            setupNoConnection()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Advertisements"
        if let reportedAdvertisementId = reportedAdvertisementId{
            getReportedAdvertisement(reportedAdvertisementId)
        }else{
            if(adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                setLabelForZeroCount(text: "No advertisements available")
            }else{
                noLabel.isHidden = true
                advertisementsSearchBar.isHidden = false
            }
            advertisementsCollectionView.reloadData()
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
          showActivityIndicator()
          adminAdvertisementViewModel.populateAdvertisements {
              self.stopActivityIndicator()
              UIView.animate(withDuration:2){
                  self.view.alpha = 1
              }
              if(self.adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                  self.setLabelForZeroCount(text: "No advertisements available")
              }else{
                  self.noLabel.isHidden = true
              }
              self.advertisementsCollectionView.reloadData()
          }
      }
      
      private func setupNoConnection() {
          noLabel.isHidden = false
          noLabel.text = "Internet Connection Not Available"
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
    
}


