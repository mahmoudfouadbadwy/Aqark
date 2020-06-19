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
    @IBOutlet weak var advertisementsSegment: CustomSegment!
    @IBOutlet weak var totalAdvertisementsLabel: UILabel!
    @IBOutlet weak var advertisementsTypeNumberLabel: UILabel!
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
            view.alpha = 0.5
            totalAdvertisementsLabel.isHidden = true
            advertisementsTypeNumberLabel.isHidden = true 
            dataAccess = AdminDataAccess()
            adminAdvertisementViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
            isDisappearing = false
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
    }
    
    private func setupAdvertisementsCollection() {
        advertisementsCollectionView.register(UINib(nibName: "AdminAdvertisementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Advertisement Cell")
        advertisementsCollectionView.delegate = self
        advertisementsCollectionView.dataSource = self
    }
    
    private func bindAdvertisementsCollection() {
        noLabel.isHidden = true
        showActivityIndicator()
        adminAdvertisementViewModel.populateAdvertisements {[weak self]  (advertisementsNumber) in
            UIView.animate(withDuration:2){
                self?.view.alpha = 1
            }
            self?.totalAdvertisementsLabel.isHidden = false
            self?.totalAdvertisementsLabel.text = "Total Advertisements: \(advertisementsNumber)"
            self?.stopActivityIndicator()
            self?.adminAdvertisementViewModel.getAdvertisementsByType(type: self!.advertisementsSegment.selectedIndex)
            if(!self!.adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                if(!self!.advertisementsSearchBar.text!.isEmpty){
                    self?.adminAdvertisementViewModel.getFilteredAdvertisements(searchText: self!.advertisementsSearchBar.text!, type: self!.advertisementsSegment.selectedIndex)
                    if(self!.adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                        self?.setLabelForZeroCount(search:true)
                    }else{
                        self?.noLabel.isHidden = true
                    }
                }
                self?.advertisementsSearchBar.isHidden = false
                self?.noLabel.isHidden = true
            }else{
                self?.setLabelForZeroCount(search: false)
            }
            self?.setAdvertisementPaymentTypeLabel()
            self?.advertisementsCollectionView.reloadData()
        }
    }
    
    private func setupNoConnection() {
        noLabel.isHidden = false
        advertisementsTypeNumberLabel.isHidden = true
        totalAdvertisementsLabel.isHidden = true
        advertisementsSearchBar.isHidden = true
        noLabel.text = "Internet Connection Not Available"
    }
    
    private func getReportedAdvertisement(_ reportedAdvertisementId: String) {
        adminAdvertisementViewModel.populateAdvertisements(){[weak self] (AdvertisementsNumber) in
            switch self?.adminAdvertisementViewModel.getReportedAdvertisementPaymentType(reportedAdvertisementId:reportedAdvertisementId){
            case "free":
                self!.advertisementsSegment.selectedIndex = 0
                self?.advertisementsSearchBar.text = reportedAdvertisementId
            case "premium":
                self!.advertisementsSegment.selectedIndex = 1
                self?.advertisementsSearchBar.text = reportedAdvertisementId
            default:
                self?.showAlert(title: "Advertisement", message: "Advertisement is deleted")
                self?.adminAdvertisementViewModel.getFilteredAdvertisements(searchText: "", type: self!.advertisementsSegment.selectedIndex)
            }
            self?.advertisementsCollectionView.reloadData()
            self?.reportedAdvertisementId = nil
        }
    }
    
    func getSelectedAdvertisement(advertisementId: String) {
        reportedAdvertisementId = advertisementId
    }
    
    func setLabelForZeroCount(search:Bool){
        advertisementsSearchBar.isHidden = !search
        noLabel.isHidden = false
        if(AdminNetworking.checkNetworkConnection()){
            if(advertisementsSegment.selectedIndex == 0){
                noLabel.text = "No available Free advertisements"
            }else{
                noLabel.text = "No available premium advertisements"
            }
        }else{
            setupNoConnection()
        }
        
    }
    
    
    @IBAction func changeAdvetisementType(_ sender: Any) {
        if(adminAdvertisementViewModel == nil && AdminNetworking.checkNetworkConnection()){
            totalAdvertisementsLabel.isHidden = true
            advertisementsTypeNumberLabel.isHidden = true
            dataAccess = AdminDataAccess()
            adminAdvertisementViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
            isDisappearing = false
            bindAdvertisementsCollection()
        }
        
        if(adminAdvertisementViewModel != nil){
            advertisementsSearchBar.text = ""
            adminAdvertisementViewModel.getAdvertisementsByType(type:advertisementsSegment.selectedIndex)
            if(adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                setLabelForZeroCount(search: false)
            }else{
                advertisementsSearchBar.isHidden = false
                noLabel.isHidden = true
            }
            totalAdvertisementsLabel.isHidden = false
            setAdvertisementPaymentTypeLabel()
            advertisementsCollectionView.reloadData()
        }
        
        if(adminAdvertisementViewModel == nil && !AdminNetworking.checkNetworkConnection()){
            setupNoConnection()
        }
    }
    
    func setAdvertisementPaymentTypeLabel(){
        advertisementsTypeNumberLabel.isHidden = false
        switch advertisementsSegment.selectedIndex{
        case 0:
            advertisementsTypeNumberLabel.text = "Free: \(adminAdvertisementViewModel.adminAdvertisementsViewList.count)"
        default:
            advertisementsTypeNumberLabel.text = "Premium: \(adminAdvertisementViewModel.adminAdvertisementsViewList.count)"
        }
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


