//
//  ProfileViewController.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
//MARK: - Live Cycle and Properties
class ProfileViewController: UIViewController {
    @IBOutlet weak var noAdvertisementsLabel: UILabel!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var addAdvertisement: UIButton!
    @IBOutlet weak var advertisementsCollection: UICollectionView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var ban:Bool!
    var logout: UIBarButtonItem!
    var gesture:UILongPressGestureRecognizer!
    var alert:UIAlertController!
    var delete:UIAlertAction!
    var cancel:UIAlertAction!
    var alertController:UIAlertController!
    var alertAction:UIAlertAction!
    var pressGesture:UITapGestureRecognizer!
    var editViewController:EditProfileViewController!
    var editAdsView:AddAdvertisementViewController!
    var addAdvertisment: AddAdvertisementViewController!
    var advertisement:ProfileAdvertisementViewModel!
    var profileViewModel:ProfileStore!
    var advertisementViewModel:ProfileAdvertisementListViewModel!
    var deleteViewModel:AdvertisementDelete!

    var editProfileVM : EditProfileViewModel!

    var profileDataAccess:ProfileDataAccess!

    var listOfAdvertisements:[ProfileAdvertisementViewModel]! = []{
        didSet{
            if listOfAdvertisements.count>0{
                noAdvertisementsLabel.isHidden = true
            }
            else
            {
                noAdvertisementsLabel.isHidden = false
            }
            advertisementsCollection.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollection()
    }
    override func viewWillAppear(_ animated: Bool) {
        if (ProfileNetworking.checkNetworkConnection())
        {
            setUpViewMoelsObjects()
            noAdvertisementsLabel.isHidden = true
            if  advertisementViewModel != nil {
                      bindCollectionData()
                  }
        }
        else
        {
            setUpNoConnectionView()
        }
    }
    private func setUpViewMoelsObjects()
    {
        if profileDataAccess == nil {
            profileDataAccess = ProfileDataAccess()
        }
        if profileViewModel == nil {
            profileViewModel = ProfileStore(by: profileDataAccess)
            setNavigationProperties()
            bindProfileData()
        }
        if  advertisementViewModel == nil {
            advertisementViewModel =
                ProfileAdvertisementListViewModel(data: profileDataAccess)
            bindCollectionData()
        }
        if deleteViewModel == nil {
            deleteViewModel = AdvertisementDelete(dataAcees: profileDataAccess)
        }
    }
    
    @IBAction func addAdvertisement(_ sender: Any) {
        if self.ban
        {
            showAlert(title:"Bolcking".localize,message:"You Are Blocked From Adding Advertisements".localize)
        }
        else
        {
            addAdvertisment = AddAdvertisementViewController()
            self.navigationController?.pushViewController(addAdvertisment, animated: true)
        }
    }
    deinit {
        profileViewModel.removeProfileDataObservers()
        profileDataAccess = nil
        advertisementViewModel.removeProfileAdvertisementsObservers()
        deleteViewModel.removeDeleteObserver()
        profileViewModel = nil
        advertisementViewModel = nil
        deleteViewModel = nil
        advertisement = nil
        logout = nil
        editViewController = nil
        addAdvertisment = nil
        editAdsView = nil
        gesture = nil
        pressGesture = nil
        alert = nil
        delete = nil
        cancel = nil
        alertController = nil
        alertAction = nil

        editProfileVM = nil
   
        listOfAdvertisements = nil
    }
}
