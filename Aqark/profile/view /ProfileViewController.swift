//
//  ProfileViewController.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK: - LiveCycle and Properties
class ProfileViewController: UIViewController {
    @IBOutlet private weak var experienceValue: UILabel!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet private weak var experienceIcon: UIImageView!
    @IBOutlet private weak var advertisementsCollection: UICollectionView!
    @IBOutlet private weak var companyName: UILabel!
    @IBOutlet private weak var companyIcon: UIImageView!
    @IBOutlet private weak var addressText: UILabel!
    @IBOutlet private weak var addressIcon: UIImageView!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var username: UILabel!
    @IBOutlet private weak var countryName: UILabel!
    @IBOutlet private weak var countryIcon: UIImageView!
    @IBOutlet private weak var profilePicture: UIImageView!
    @IBOutlet private weak var userRole: UILabel!
    private let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private let profileDataAccess:ProfileDataAccess = ProfileDataAccess()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.advertisementsCollection.register(UINib(nibName: "ProfileAdvertisementCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        self.advertisementsCollection.dataSource = self
        self.advertisementsCollection.delegate = self
        
    }
    
    
}

//MARK: - Profile Data
extension ProfileViewController{
    func setupView()
    {
        profilePicture.isHidden = true
        editProfile.isHidden = true
        bindData()
        showIndicator()
        setupOptionalViews(hide: true)
    }
    func setupOptionalViews(hide status:Bool)
    {
        countryIcon.isHidden = status
        countryName.isHidden = status
        addressIcon.isHidden = status
        addressText.isHidden = status
        companyIcon.isHidden = status
        companyName.isHidden = status
        experienceIcon.isHidden = status
        experienceValue.isHidden = status
    }
    func setProfilePicture()
    {
        profilePicture.isHidden = false
    }
    func setCompanyName(with name:String)
    {
        if name.elementsEqual("")
        {
             self.companyName.text = "--"
        }else
        {
            self.companyName.text = name
        }
    }
    func setAddress(with address:String)
    {
        if (address.elementsEqual(""))
        {
            self.addressText.text = "--"
        }
        else
        {
            self.addressText.text = address
        }
    }
    
    func setExperience(with experience:String){
        if experience.elementsEqual("")
        {
             self.experienceValue.text = "--"
        }
        else
        {
            self.experienceValue.text = experience
        }
    }
    
}

//MARK: - Bind Data
extension ProfileViewController{
    func bindData()
    {
        let profileViewModel:ProfileStore = ProfileStore(by: profileDataAccess)
        profileViewModel.getProfileData(onSuccess: {[weak self]
            (profileData) in
            self?.stopIndicator()
            self?.userRole.text = profileData.role
            self?.username.text = profileData.username
            self?.email.text = profileData.email
            self?.setProfilePicture()
            self?.editProfile.isHidden = false
            if profileData.role.lowercased().elementsEqual("user")
            {
                self?.setupOptionalViews(hide: true)
            }
            else
            {
                self?.countryName.text = profileData.country
                self?.setCompanyName(with: profileData.company)
                self?.setAddress(with: profileData.address)
                self?.setExperience(with: profileData.experience)
                self?.setupOptionalViews(hide: false)
            }
            
            }, onFailure: {
                (error) in
                print("\(error.localizedDescription)")
        })
    }
}

extension ProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProfileAdvertisementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileAdvertisementCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    
}

//MARK: - UIViewIndicator
extension ProfileViewController{
    func showIndicator()
    {
        networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
    func stopIndicator() {
        networkIndicator.stopAnimating()
    }
}
