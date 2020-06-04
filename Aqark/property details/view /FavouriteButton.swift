//
//  FavouriteButton.swift
//  Aqark
//
//  Created by Mostafa Samir on 6/2/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension PropertyDetailView {
    func setupCoredata (){
        self.coreDataViewModel=CoreDataViewModel(dataAccess: CoreDataAccess())
    }
    
    func checkIfFavourite (){
        if (coreDataViewModel!.isAdvertismentExist(id: self.advertisementId)){
            favButton.image = UIImage(named: "red-heart")
        }else{
             favButton.image = UIImage(named: "heart")
        }
    }
    
    @objc func toogleFavorite()
    {
        if (coreDataViewModel!.isAdvertismentExist(id: self.advertisementId))
        {
             favButton.image = UIImage(named: "heart")
            self.coreDataViewModel!.deleteAdvertismentFromFavourite(id: self.advertisementId)
        }else{
            if((coreDataViewModel?.checkNumberOfAdvertisment())!){
                 favButton.image = UIImage(named: "red-heart")
                self.coreDataViewModel!.addAdvertismentToFavourite(id: self.advertisementId)
                
            }else{
                let alert = UIAlertController(title: "Add To Favourite", message: "Can't add to favourite maximum 20 Ads can be added ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
