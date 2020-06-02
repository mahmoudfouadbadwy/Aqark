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
    let profileDataAccess:ProfileDataAccess = ProfileDataAccess()
    var listOfAdvertisements:[ProfileAdvertisementViewModel] = []{
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
        if(ProfileNetworking.checkNetworkConnection())
        {
           
                setupView()
                setNavigationProperties()
                setupCollection()
                noAdvertisementsLabel.isHidden = true
        
        }
        else
        {
            setUpNoConnectionView()
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if (ProfileNetworking.checkNetworkConnection())
        {
            if !ProfileNetworking.checkAuthuntication(){
                self.navigationController?.pushViewController(FirstScreenViewController(), animated: true)
            }
            else
            {
                showActivityIndicator()
                bindProfileData()
                bindCollectionData()
                noAdvertisementsLabel.isHidden = true
            }
        }
    }
}
