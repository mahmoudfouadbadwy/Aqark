//
//  CollectionViewExtension.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/18/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import MapKit

extension SearchViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if advertismentsListViewModel != nil{
            return isFiltering ? filteredAdsList.count : advertismentsListViewModel.advertismentsViewModel.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AdvertisementCellCollectionViewCell
        updateCellLayout(cell: cell)
        getCellData(indexPath: indexPath)
        cell.advertisementImage?.sd_setImage(with: URL(string: adViewModel.image), placeholderImage: UIImage(named: "NoImage"))
        cell.propertyTypeLabel?.text = adViewModel.propertyType
        cell.proprtyAddressLabel?.text = adViewModel.address
        cell.numberOfBedsLabel?.text = adViewModel.bedRoomsNumber
        cell.numberOfBathRoomsLabel?.text = adViewModel.bathRoomsNumber
        cell.propertySizeLabel?.text = "\(adViewModel.size ?? "") sqm"
        if adViewModel.advertisementType == "Rent"{
            cell.propertyPriceLabel?.text = "\(adViewModel.price ?? 0) EGP/month"
        }else{
            cell.propertyPriceLabel?.text = "\(adViewModel.price ?? 0) EGP"
        }
        
        
        cell.favButton.setTitle(adViewModel.advertisementId, for: .normal)
        self.setFavouriteButton(btn: cell.favButton, id: adViewModel.advertisementId)
        cell.delegat = self

        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let propertyDetailVC = PropertyDetailView()
        propertyDetailVC.advertisementId = (arrOfAdViewModel![indexPath.row].advertisementId)!
        self.navigationController?.pushViewController(propertyDetailVC, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

extension SearchViewController{
    func updateCellLayout(cell : UICollectionViewCell ){
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    func setUpCollectionView()
    {
        searchCollectionView.register(UINib(nibName: "AdvertisementCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func getCollectionViewData(){
        self.data = AdvertisementData()
        self.advertismentsListViewModel = AdvertisementListViewModel(dataAccess: self.data)
        advertismentsListViewModel.populateAds {
            (dataResults) in
            if dataResults.isEmpty{
                self.stopIndicator()
                self.labelPlaceHolder.text = "No Advertisements Found"
                self.view.alpha = 1
                self.manageAppearence(sortBtn: true, labelPlaceHolder: false, notificationBtn: true)
            }else{
                self.arrOfAdViewModel = dataResults
                self.arrOfAdViewModel.forEach { self.counts[$0.address, default: 0] += 1 }
                self.putLocationOnMap()
                self.labelPlaceHolder.isHidden = true
            }
        }
    }
  

    func getCellData(indexPath : IndexPath){
        if isFiltering {
            adViewModel = filteredAdsList[indexPath.row]
            notificationBtn.isHidden = false
        }else if isSorting == "High Price"{
            sortedList = self.sortData(str: isSorting)
            adViewModel = sortedList[indexPath.row]
        }else if isSorting == "Low Price"{
            sortedList = self.sortData(str: isSorting)
            adViewModel = sortedList[indexPath.row]
        }else if isSorting == "Newest"{
            sortedList = self.sortData(str: isSorting)
            adViewModel = sortedList[indexPath.row]
        }else if isSorting == "Oldest"{
            sortedList = self.sortData(str: isSorting)
            adViewModel = sortedList[indexPath.row]
        }else {
            if let arrOfAdViewModel = arrOfAdViewModel{
                adViewModel = arrOfAdViewModel[indexPath.row]
                manageAppearence(sortBtn: false, labelPlaceHolder: true, notificationBtn: true)
            }else{
                adViewModel = self.advertismentsListViewModel.advertismentsViewModel[indexPath.row]
            }
        }
    }
}
