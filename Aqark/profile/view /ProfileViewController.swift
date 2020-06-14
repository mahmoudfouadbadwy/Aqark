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
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var experienceValue: UILabel!
    @IBOutlet weak var containerStack: UIStackView!
    @IBOutlet weak var phoneValue: UILabel!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var advertisementsCollection: UICollectionView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var ban:Bool!
    var advertisement:ProfileAdvertisementViewModel!
    var profileViewModel:ProfileStore!
    var advertisementViewModel:ProfileAdvertisementListViewModel!
    var deleteViewModel:AdvertisementDelete!
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
            showActivityIndicator()
            setNavigationProperties()
            bindProfileData()
            bindCollectionData()
            noAdvertisementsLabel.isHidden = true
        }
        else
        {
            setUpNoConnectionView()
        }
    }
    private func setUpViewMoelsObjects()
    {
        profileViewModel = ProfileStore(by: ProfileDataAccess())
        advertisementViewModel =
            ProfileAdvertisementListViewModel(data: ProfileDataAccess())
        deleteViewModel = AdvertisementDelete(dataAcees: ProfileDataAccess())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if profileViewModel != nil {
            profileViewModel.removeProfileDataObservers()
        }
        if advertisementViewModel != nil {
            advertisementViewModel.removeProfileAdvertisementsObservers()
        }
        if deleteViewModel != nil {
            deleteViewModel.removeDeleteObserver()
        }
        profileViewModel = nil
        advertisementViewModel = nil
        deleteViewModel = nil
        advertisement = nil
        print("view will disapear profile")
    }
    deinit {
        listOfAdvertisements = nil
    }
}
