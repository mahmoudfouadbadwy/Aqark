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
       
        if (coreDataViewModel!.isAdvertismentExist(id: arrOfAdViewModel[index].advertisementId)){
            cell.favButton.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        }else{
            cell.favButton.tintColor = UIColor.gray
        }
        cell.favButton.tag = index
        cell.delegat = self
    }
    
    func addToFav(favButton: UIButton) {
 
        let advertisment = arrOfAdViewModel[favButton.tag] 
        
        if (coreDataViewModel!.isAdvertismentExist(id:advertisment.advertisementId)){
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this advertisement from favourite list ? ", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
                self.coreDataViewModel!.deleteAdvertismentFromFavourite(id: (advertisment.advertisementId))
                self.arrOfAdViewModel.remove(at: favButton.tag)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }
 
    }
    
    
}

