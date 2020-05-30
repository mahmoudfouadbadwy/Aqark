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
        print("  count  \(favouriteListViewModel.favouriteViewModel.count)")
        if favouriteListViewModel != nil{
            return favouriteListViewModel.favouriteViewModel.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FavouriteCollectionViewCell
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
        
        self.setFavouriteButton(cell: cell, index: indexPath.row)
        
        return cell
    }
}

extension FavouriteViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let propertyDetailVC = PropertyDetailView()
        propertyDetailVC.advertisementId = (arrOfAdViewModel![indexPath.row].advertisementId)!
        self.navigationController?.pushViewController(propertyDetailVC, animated: true)
    }
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height/3)
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
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    func setUpCollectionView()
    {
        favouriteCollectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func getCollectionViewData(){
        self.dataAccess = FavouriteDataAccess()
        self.favouriteListViewModel = FavouriteListViewModel(dataAccess: self.dataAccess)
        favouriteListViewModel.populateAds {
            (dataResults) in
          //  if dataResults.isEmpty{
//                print("  is empty  ")
//            }else{
            print("  result  \(dataResults)  ")
                self.arrOfAdViewModel = dataResults
           // }
        }
    }
    
    func getCellData(indexPath : IndexPath){
        
            if let arrOfAdViewModel = arrOfAdViewModel{
                adViewModel = arrOfAdViewModel[indexPath.row]
            }else{
                adViewModel = self.favouriteListViewModel.favouriteViewModel[indexPath.row]
            }
        
    }
}
