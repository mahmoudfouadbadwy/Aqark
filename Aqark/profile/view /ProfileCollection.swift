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
            self?.stopActivityIndicator()
            self?.listOfAdvertisements = advertisements
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
        cell.propertyType.text = advertisement.propertyType.localize
        
        if advertisement.advertisementType.elementsEqual("Rent".localize) || advertisement.advertisementType.lowercased().elementsEqual("ايجار".localize )
        {
            cell.propertyPrice?.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(advertisement.price))).1 + "EGP/month".localize
        }else
        {
            cell.propertyPrice?.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(advertisement.price))).1 + "EGP".localize
        }
        
        
        
        cell.propertySize.text = self.convertNumbers(lang:"lang".localize , stringNumber: advertisement.size ).1+"sqm".localize
        cell.propertyAddress.text = advertisement.address
        cell.bedNumber.text = self.convertNumbers(lang:"lang".localize , stringNumber: advertisement.bedroom).1
        cell.bathRoomNumber.text = self.convertNumbers(lang:"lang".localize , stringNumber: advertisement.bathroom).1
        cell.propertyImage.sd_setImage(with: URL(string: advertisement.image), placeholderImage: UIImage(named: "NoImage"))
        if "lang".localize.elementsEqual("en"){
            cell.paymentType.text = advertisement.payment.localize.capitalized
        }else{
            cell.paymentType.text = advertisement.payment.localize
        }
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
        let editView:AddAdvertisementViewController = AddAdvertisementViewController()
        editView.advertisementId = listOfAdvertisements[indexPath.row].advertisementId
        self.navigationController?.pushViewController(editView, animated: true)
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
        let alert:UIAlertController = UIAlertController(title: "Delete Adverisement".localize, message: "Are You Sure You Want To Delete This Advertisement ?".localize, preferredStyle: .actionSheet)
        let delete:UIAlertAction = UIAlertAction(title: "Delete".localize, style: .default) { (action) in
            completion(true)
        }
        let cancel:UIAlertAction = UIAlertAction(title: "Cancel".localize, style: .cancel) { (action) in
            alert.dismiss(animated: true)
            completion(false)
        }
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}


