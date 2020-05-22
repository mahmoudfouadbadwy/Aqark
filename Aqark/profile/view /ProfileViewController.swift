//
//  ProfileViewController.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Cosmos
import ReachabilitySwift
import Firebase
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
    let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
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
        if(checkNetworkConnection())
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
        if (checkNetworkConnection())
        {
            if Auth.auth().currentUser == nil{
                self.navigationController?.pushViewController(FirstScreenViewController(), animated: true)
            }
            else
            {
                showIndicator()
                bindProfileData()
                bindCollectionData()
                noAdvertisementsLabel.isHidden = true
            }
        }
    }
    
    func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}
