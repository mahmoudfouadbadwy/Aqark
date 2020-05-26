//
//  ProfileCollection.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import SDWebImage

extension ProfileViewController{
    func setupCollection()
    {
        self.advertisementsCollection.register(UINib(nibName: "AdvertisementCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        self.advertisementsCollection.dataSource = self
        self.advertisementsCollection.delegate = self
        setupCollectionGeusture()
    }
    
    func bindCollectionData()
    {
        let advertisementViewModel:ProfileAdvertisementListViewModel =
            ProfileAdvertisementListViewModel(data: profileDataAccess)
        advertisementViewModel.getAllAdvertisements(completion: {[weak self]
            (advertisements) in
            self?.stopIndicator()
            self?.listOfAdvertisements = advertisements
            self?.showByAnimation()
        })
    }
    private func setCellConfiguration(cell:UICollectionViewCell)
    {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    private func setCellData(cell:ProfileAdvertisementCell,indexPath:IndexPath)
    {
        let advertisement:ProfileAdvertisementViewModel = listOfAdvertisements[indexPath.row]
        cell.propertyType.text = advertisement.propertyType
        if advertisement.advertisementType.lowercased().elementsEqual("rent")
        {
            cell.propertyPrice.text = "\(advertisement.price ?? 0.0) EGP/month"
        }else
        {
            cell.propertyPrice.text = "\(advertisement.price ?? 0.0) EGP"
        }
        
        cell.propertySize.text = "\(advertisement.size ?? "") sqm"
        cell.propertyAddress.text = advertisement.address
        cell.bedNumber.text = advertisement.bedroom
        cell.bathRoomNumber.text = advertisement.bathroom
        cell.propertyImage.sd_setImage(with: URL(string: advertisement.image), placeholderImage: UIImage(named: "NoImage"))
        cell.paymentType.text = advertisement.payment.capitalized
    }
}



extension ProfileViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfAdvertisements.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProfileAdvertisementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileAdvertisementCell
        setCellData(cell: cell, indexPath: indexPath)
        setCellConfiguration(cell: cell)
        return cell
    }
}

extension ProfileViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


extension ProfileViewController:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 40, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}


extension ProfileViewController:UIGestureRecognizerDelegate{
    func setupCollectionGeusture()
    {
        let gesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(deleteCell(gesture:)))
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        self.advertisementsCollection.addGestureRecognizer(gesture)
    }
    
    @objc private func deleteCell(gesture:UILongPressGestureRecognizer )
    {
        if (gesture.state != .ended)
        {
            return
        }else
        {
            let  point = gesture.location(in: self.advertisementsCollection)
            if let indexPath =  self.advertisementsCollection.indexPathForItem(at: point)
            {
                showAlert(completion: { (res) in
                    if (res)
                    {
                        self.advertisementsCollection.performBatchUpdates({
                             // delete from firebase.
                            let deleteViewModel:AdvertisementDelete = AdvertisementDelete(dataAcees: self.profileDataAccess)
                            deleteViewModel.deleteAdvertisement(id:self.listOfAdvertisements[indexPath.row].advertisementId )
                            // delete from view .
                            self.listOfAdvertisements.remove(at: indexPath.row)
                            self.advertisementsCollection.deleteItems(at: [indexPath])
                        }) { (finished) in
                            self.advertisementsCollection.reloadData()
                        }
                    }
                })
            }
        }
    }
    
   private func showAlert(completion:@escaping(Bool)->Void)
    {
        let alert:UIAlertController = UIAlertController(title: "Delete Adverisement", message: "Are You Sure You Want To Delete This Advertisement ?", preferredStyle: .actionSheet)
        let delete:UIAlertAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            completion(true)
        }
        let cancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true)
            completion(false)
        }
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}


