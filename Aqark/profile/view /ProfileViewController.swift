//
//  ProfileViewController.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK: - Live Cycle and Properties
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var optionalIcons: UIStackView!
    @IBOutlet weak var optionalText: UIStackView!
    @IBOutlet  weak var phoneValue: UILabel!
    @IBOutlet  weak var editProfile: UIButton!
    @IBOutlet  weak var advertisementsCollection: UICollectionView!
    @IBOutlet  weak var companyName: UILabel!
    @IBOutlet  weak var addressText: UILabel!
    @IBOutlet  weak var email: UILabel!
    @IBOutlet  weak var username: UILabel!
    @IBOutlet  weak var countryName: UILabel!
    @IBOutlet  weak var profilePicture: UIImageView!
    @IBOutlet  weak var userRole: UILabel!
    let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    let profileDataAccess:ProfileDataAccess = ProfileDataAccess()
    var listOfAdvertisements:[ProfileAdvertisementViewModel] = []{
        didSet{
            advertisementsCollection.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationProperties()
        setupView()
        setupCollection()
    }
    
    
}
