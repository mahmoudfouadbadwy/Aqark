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
    
    
    func setFavouriteButton (cell: FavouriteCollectionViewCell,index: Int){
       
        if coreDataViewModel != nil {
            if (coreDataViewModel.isAdvertismentExist(id: arrOfAdViewModel[index].advertisementId)){
                cell.favButton.image("red-heart")
            }else{
                cell.favButton.tintColor = UIColor.gray
            }
            cell.favButton.tag = index
            cell.delegat = self
        }
    }
    
    func addToFav(favButton: UIButton) {
 
       
        
        if (coreDataViewModel!.isAdvertismentExist(id:arrOfAdViewModel[favButton.tag].advertisementId)){
            alert = UIAlertController(title: "Delete".localize, message: "Are you sure you want to delete this advertisement from favourite list ? ".localize, preferredStyle: .actionSheet)
            
            
            alert.addAction(UIAlertAction(title: "Delete".localize, style: .default, handler: {[weak self] (action) in
                
                 
                if (self?.coreDataViewModel!.deleteAdvertismentFromFavourite(id:(self?.arrOfAdViewModel[favButton.tag].advertisementId) ?? "") ?? false)
                {
                    self?.arrOfAdViewModel.remove(at: favButton.tag)
                }
                else
                {
                    let alert = UIAlertController(title: "Delete".localize, message: "Can't delete thie advertisment. ".localize, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Ok".localize, style: .cancel, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
                
            }))
            
            
            alert.addAction(UIAlertAction(title: "Cancel".localize, style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }
 
    }
    
    
}

