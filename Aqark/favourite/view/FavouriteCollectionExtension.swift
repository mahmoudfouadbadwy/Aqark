//
//  FavouriteCollectionExtension.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension FavouriteViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrOfAdViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FavouriteCollectionViewCell
        updateCellLayout(cell: cell)
        adViewModel = arrOfAdViewModel[indexPath.row]
        cell.advertisementImage?.sd_setImage(with: URL(string: adViewModel.image), placeholderImage: UIImage(named: "NoImage"))
        cell.propertyTypeLabel?.text = adViewModel.propertyType.localize
        cell.proprtyAddressLabel?.text = adViewModel.address
        cell.numberOfBedsLabel?.text =  self.convertNumbers(lang:"lang".localize , stringNumber: adViewModel.bedRoomsNumber).1
        cell.numberOfBathRoomsLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: adViewModel.bathRoomsNumber).1
        cell.propertySizeLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: adViewModel.size).1+"sqm".localize
        if adViewModel.advertisementType == "Rent"{
            cell.propertyPriceLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(adViewModel.price))).1 + "EGP/month".localize
        }else{
            cell.propertyPriceLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(adViewModel.price))).1 + "EGP".localize
        }
        
        self.setFavouriteButton(cell: cell, index: indexPath.row)
        
        return cell
    }
}

extension FavouriteViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let propertyDetailVC = PropertyDetailView()
        propertyDetailVC.advertisementId = (arrOfAdViewModel[indexPath.row].advertisementId)!
        self.navigationController?.pushViewController(propertyDetailVC, animated: true)
    }
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

extension FavouriteViewController{
    func updateCellLayout(cell : UICollectionViewCell ){
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(rgb: 0x1d3557).cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    func setUpCollectionView()
    {
        favouriteCollectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func getCollectionViewData(){
        if coreDataViewModel?.getAllFavouriteAdvertisment().count ?? 0 > 0{
            showActivityIndicator()
            self.favouriteListViewModel.populateAds(completionForGetAllAdvertisements: {[weak self] (allFavAds, numOfFavAds) in
                self?.arrOfAdViewModel.removeAll()
                self?.adsCount = numOfFavAds
                self?.stopActivityIndicator()
                self?.arrOfAdViewModel = allFavAds
                self?.showDeletedAdsAlert()})
        }else{
            arrOfAdViewModel=[]
        }
    }

}
