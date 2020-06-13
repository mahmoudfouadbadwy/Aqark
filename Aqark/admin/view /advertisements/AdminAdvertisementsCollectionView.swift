//
//  AdminAdvertisementsCollectionView.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit
    
    extension AdminAdvertisementsViewController : UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width - 40, height: 150)
        }
    }
    
    extension AdminAdvertisementsViewController : UICollectionViewDataSource,UICollectionViewDelegate{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return isDisappearing ? 0 : self.adminAdvertisementViewModel.adminAdvertisementsViewList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let advertisementCell = advertisementsCollectionView.dequeueReusableCell(withReuseIdentifier: "Advertisement Cell", for: indexPath) as! AdminAdvertisementCollectionViewCell
            advertisementCell.adminAdvertisementsDelegate = self
            advertisementCell.adminAdvertisementsCellIndex = indexPath
            advertisementCell.advertisementPropertyType.text = adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyType
            advertisementCell.advertisementPropertyPrice.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyPrice
            advertisementCell.advertisementPropertyAddress.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyAddress
            advertisementCell.advertisementPropertySize.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertySize
            advertisementCell.advertisementPropertyBedNumbers.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyBedsNumber
            advertisementCell.advertisementPropertyBathRoomNumbers.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyBathRoomsNumber
            let advertisementPropertyImageURL = URL(string:self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyImages[0])
            advertisementCell.advertisementPropertyImage.sd_setImage(with:advertisementPropertyImageURL , placeholderImage: UIImage(named: "NoImage"))
            return advertisementCell
        }
}

