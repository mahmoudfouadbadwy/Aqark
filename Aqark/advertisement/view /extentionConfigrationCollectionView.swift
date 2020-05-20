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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idAddAdvertisementsCollectionViewCell", for: indexPath) as! AddAdvertisementsCollectionViewCell
        cell.imageForCell.image = UIImage(data: selectedImages[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.selectedImages.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
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
    
}
