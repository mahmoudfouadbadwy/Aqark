//
//  CollectionViewExtension.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/18/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import MapKit
import Social

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
        cell.propertyTypeLabel?.text = adViewModel.propertyType.localize
        cell.proprtyAddressLabel?.text = adViewModel.address
        cell.numberOfBedsLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: adViewModel.bedRoomsNumber).1
        cell.numberOfBathRoomsLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: adViewModel.bathRoomsNumber).1
        cell.propertySizeLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: adViewModel.size).1+"sqm".localize
        if adViewModel.advertisementType == "Rent"{
            
            cell.propertyPriceLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(adViewModel.price))).1 + "EGP/month".localize
        }else{
            cell.propertyPriceLabel?.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(adViewModel.price))).1 + "EGP".localize
        }
        cell.favButton.setTitle(adViewModel.advertisementId, for: .normal)
        if (coreDataViewModel!.isAdvertismentExist(id: adViewModel.advertisementId)){
            cell.favButton.image("red-heart")
        }
        else
        {
            cell.favButton.image("heart")
        }
        cell.delegat = self
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let propertyDetailVC = PropertyDetailView()
        if isSorted == true {

            propertyDetailVC.advertisementId = (sortedList[indexPath.row].advertisementId)!
        }else if isFiltering == true {
            propertyDetailVC.advertisementId =
                (filteredAdsList[indexPath.row].advertisementId)!
        }else{
            propertyDetailVC.advertisementId = (arrOfAdViewModel![indexPath.row].advertisementId)!
        }
        self.navigationController?.pushViewController(propertyDetailVC, animated: true)

    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 150)
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
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(rgb: 0x1d3557).cgColor
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
        advertismentsListViewModel.populateAds {[weak self]
            (dataResults) in
            UIView.animate(withDuration:2) {
                self?.view.alpha = 1
            }
            if dataResults.isEmpty{
                self?.stopActivityIndicator()
                self?.labelPlaceHolder.text = "No Advertisements Available".localize
                self?.sort = nil
                self?.labelPlaceHolder.isHidden = false
                self?.searchBar.isHidden = true
            }else{
                self?.stopActivityIndicator()
                self?.arrOfAdViewModel = dataResults
                self?.arrOfAdViewModel.forEach { self?.counts[$0.address, default: 0] += 1 }
                self?.putLocationOnMap()
                self?.labelPlaceHolder.isHidden = true
                if self?.isFiltering == true {
                    self?.filteredAdsList = dataResults.filter {[weak self] advertisement -> Bool in
                        return advertisement.address.lowercased().contains(self!.searchBar.text!.lowercased())
                    }
                    
                }
                self?.searchCollectionView.reloadData()
            }
        }
    }

    func getCellData(indexPath : IndexPath){
        if isFiltering {
            adViewModel = filteredAdsList[indexPath.row]
        }
        else {
            if let arrOfAdViewModel = arrOfAdViewModel{
                adViewModel = arrOfAdViewModel[indexPath.row]
            }else{
                adViewModel = self.advertismentsListViewModel.advertismentsViewModel[indexPath.row]
            }
        }
        if !isSorting.elementsEqual("") {
            sortedList = self.sortData(str: isSorting)
            adViewModel = sortedList[indexPath.row]
        }
    }
}

