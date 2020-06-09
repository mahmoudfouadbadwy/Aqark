//
//  extentionConfigrationCollectionView.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit


extension AddAdvertisementViewController: UICollectionViewDataSource , UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var count = 0
        if section == 0{
            count = selectedImages.count
        }
        else{
            count = urlImages.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idAddAdvertisementsCollectionViewCell", for: indexPath) as! AddAdvertisementsCollectionViewCell
        
        if indexPath.section == 0{
            cell.imageForCell.image = UIImage(data: selectedImages[indexPath.row])
        }else{
            cell.imageForCell.sd_setImage(with: URL(string: urlImages[indexPath.row]), placeholderImage: UIImage(named: "NoImage"))
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        alertDesitionMaking(title: "Delete ", message: "Are you sure you want to delete ?" , index : indexPath)
    }
    func registerCellOfCollectionView()
    {
        var collectionViewFlowLayout:UICollectionViewFlowLayout!
        if collectionViewFlowLayout == nil
        {
            let minimunLineSpacing :CGFloat = 10
            let minimunInteritemSpacing :CGFloat = 0
            let width = (collectionView.bounds.size.height)
            let height = (collectionView.bounds.size.height)
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.minimumLineSpacing = minimunLineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = minimunInteritemSpacing
            collectionView.setCollectionViewLayout(collectionViewFlowLayout , animated: true)
        }
    }
    
    func alertDesitionMaking(title: String , message : String , index : IndexPath){
        
        let alertController = UIAlertController(title: "Delete Image", message: "Are you sure you want to delete ?" , preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel ,handler: nil)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            if index.section == 0{
                self.selectedImages.remove(at: index.row)
                self.collectionView.deleteItems(at: [index])
            }else{
                self.urlImageDeleted.append(self.urlImages[index.row])
                self.urlImages.remove(at: index.row)
                self.collectionView.deleteItems(at: [index])
                // we will go to fire base to delete image forom there
                
            }
            
        }
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
