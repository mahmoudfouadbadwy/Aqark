//
//  FavouriteButton.swift
//  Aqark
//
//  Created by Mostafa Samir on 6/2/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension PropertyDetailView : FavouriteButtonProtocol{
    func setupCoredata (){
        self.coreDataViewModel=CoreDataViewModel(dataAccess: CoreDataAccess())
    }
    
    func checkIfFavourite (){
        if (coreDataViewModel!.isAdvertismentExist(id: self.advertisementId)){
            imageSlider.favouriteButton.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        }else{
            imageSlider.favouriteButton.tintColor = UIColor.white
        }
    }
    
    func addAdvertismentToFav() {

        if (coreDataViewModel!.isAdvertismentExist(id: self.advertisementId))
        {
            imageSlider.favouriteButton.tintColor = UIColor.white
            self.coreDataViewModel!.deleteAdvertismentFromFavourite(id: self.advertisementId)
        }else{
            if((coreDataViewModel?.checkNumberOfAdvertisment())!){
                imageSlider.favouriteButton.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
                self.coreDataViewModel!.addAdvertismentToFavourite(id: self.advertisementId)
                
            }else{
                let alert = UIAlertController(title: "Add To Favourite", message: "Can't add to favourite maximum 20 Ads can be added ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
