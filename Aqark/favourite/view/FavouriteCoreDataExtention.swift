//
//  FavouriteCoreDataExtention.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension FavouriteViewController:FavouriteProtocol{
    
    func setupCoredata (){
        self.coreDataViewModel=CoreDataViewModel(dataAccess: CoreDataAccess())
    }
    
    func setFavouriteButton (cell: FavouriteCollectionViewCell,index: Int){
        let storedIds = coreDataViewModel?.getAllFavouriteAdvertisment()
        print("  storedIds  \(storedIds?.count) ")
        if (storedIds?.count != 0){
            for i in 0..<storedIds!.count{
                if(storedIds![i] == arrOfAdViewModel[index].advertisementId){
                    cell.favButton.tintColor = UIColor.red
            }
        }
        }
        
        cell.favButton.tag = index
        cell.delegat = self
    }
    
    func addToFav(favButton: UIButton) {
 
        let advertisment = arrOfAdViewModel[favButton.tag] 
        
        if (favButton.tintColor == UIColor.red){
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this advertisement from favourite list ? ", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
                favButton.tintColor = UIColor.lightGray
                self.coreDataViewModel!.deleteAdvertismentFromFavourite(id: (advertisment.advertisementId))
                print("  favButton.tag  \(favButton.tag)")
                self.arrOfAdViewModel.remove(at: favButton.tag)
                if(self.arrOfAdViewModel.count == 0){
                    self.labelPlaceHolder.isHidden = false
                    self.labelPlaceHolder.text = "There is no advertisements in favourite list."
                }
                self.favouriteCollectionView.reloadData()

            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }else{
            if((coreDataViewModel?.checkNumberOfAdvertisment())!){
                favButton.tintColor = UIColor.red
                self.coreDataViewModel!.addAdvertismentToFavourite(id: (advertisment.advertisementId))
            }else{
                let alert = UIAlertController(title: "Add To Favourite", message: "Can't add to favourite maximum 20 Ads can be added ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
 
    }
    
    
}

