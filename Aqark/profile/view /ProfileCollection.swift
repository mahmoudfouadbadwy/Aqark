//
//  ProfileCollection.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
extension ProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProfileAdvertisementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileAdvertisementCell
        if listOfAdvertisements.count>0{
            let advertisement:ProfileAdvertisementViewModel = listOfAdvertisements[indexPath.row]
            cell.propertyType.text = advertisement.propertyType
            cell.propertyPrice.text = advertisement.price
            cell.propertySize.text = advertisement.size
            cell.propertyAddress.text = advertisement.address
            cell.bedNumber.text = advertisement.bedroom
            cell.bathRoomNumber.text = advertisement.bathroom
        }
       
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
    
    func setupCollection()
    {
        self.advertisementsCollection.register(UINib(nibName: "ProfileAdvertisementCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        self.advertisementsCollection.dataSource = self
        self.advertisementsCollection.delegate = self
        let advertisementViewModel:ProfileAdvertisementListViewModel =
        ProfileAdvertisementListViewModel(data: profileDataAccess)
        advertisementViewModel.getAllAdvertisements(completion: {[weak self]
            (advertisements) in
            self?.listOfAdvertisements = advertisements
        })
        
    }
    
}
