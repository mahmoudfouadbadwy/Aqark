//
//  AdminAdvertisementsCollectionView.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension AdminAdvertisementsViewController : UICollectionViewDelegate,AdminAdvertisementsCollectionDelegate{
    
    func removeAdvertisementDelegate(at indexPath: IndexPath) {
        showAlert { (result) in
            if(result){
                self.advertisementsCollectionView.performBatchUpdates({
                    self.adminAdvertisementViewModel.deleteAdvertisement(adminAdvertisement: self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row]){(deleted) in
                        if(deleted){
                            self.adminAdvertisementViewModel.adminAdvertisementsViewList.remove(at: indexPath
                                .row)
                            self.advertisementsCollectionView.deleteItems(at: [indexPath])
                            self.showAlert(title: "Advertisement",message: "Advertisement deleted successfully")
                        }else{
                            self.showAlert(title: "Advertisement", message: "There is problem with deleting advertisement")
                        }
                    }
                    
                }) { (finished) in
                    self.advertisementsCollectionView.reloadData()
                }
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

extension AdminAdvertisementsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 150)
    }
}

extension AdminAdvertisementsViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return self.adminAdvertisementViewModel.adminAdvertisementsViewList.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let advertisementCell = advertisementsCollectionView.dequeueReusableCell(withReuseIdentifier: "Advertisement Cell", for: indexPath) as! AdminAdvertisementCollectionViewCell
          advertisementCell.adminAdvertisementsDelegate = self
          advertisementCell.adminAdvertisementsCellIndex = indexPath
          advertisementCell.advertisementPropertyType.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyType
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
