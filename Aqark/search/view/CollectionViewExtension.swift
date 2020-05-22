//
//  CollectionViewExtension.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/18/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension SearchViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

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
        var adViewModel : AdvertisementViewModel
        if isFiltering {
            adViewModel = filteredAdsList[indexPath.row]
        } else {
            placeHolderView.isHidden = true
            if let arrOfAdViewModel = arrOfAdViewModel{
                adViewModel = arrOfAdViewModel[indexPath.row]
                sortBtn.isHidden = false
                swapLabel.isHidden = false
            }else{
                adViewModel = self.advertismentsListViewModel.advertismentsViewModel[indexPath.row]
            }
        }
        
        cell.advertisementImage?.sd_setImage(with: URL(string: adViewModel.image), placeholderImage: UIImage(named: "NoImage"))
        cell.propertyTypeLabel?.text = adViewModel.propertyType
        cell.proprtyAddressLabel?.text = adViewModel.address
        cell.numberOfBedsLabel?.text = adViewModel.bedRoomsNumber
        cell.numberOfBathRoomsLabel?.text = adViewModel.bathRoomsNumber
        cell.propertySizeLabel?.text = "\(adViewModel.size ?? "") sqm"
        if adViewModel.advertisementType == "Rent"{
            cell.propertyPriceLabel?.text = "\(adViewModel.price ?? "") EGP/month"
        }else{
            cell.propertyPriceLabel?.text = "\(adViewModel.price ?? "") EGP"
        }
        return cell
    }
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
    let adId = (arrOfAdViewModel![indexPath.row].advertisementId)!
    let propertyDetailVC = PropertyDetailView()
    self.navigationController?.pushViewController(propertyDetailVC, animated: true)
    }




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

    func updateFlowLayout()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemPerRow :CGFloat = 1.03
            let minimunLineSpacing :CGFloat = 10
            let minimunInteritemSpacing :CGFloat = 20
            let width = (searchCollectionView.frame.width / numberOfItemPerRow)
            let height = (searchCollectionView.frame.height/3.5)

            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.minimumLineSpacing = minimunLineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = minimunInteritemSpacing
            searchCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }


}
