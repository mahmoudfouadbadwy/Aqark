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
            favButton.setImage(UIImage(named: "red-heart"), for: .normal)
        }else{
            favButton.setImage( UIImage(named: "heart"), for: .normal)
        }
    }
    
    @objc func shareAdvertisementContent(){
        let vc = UIActivityViewController(activityItems: ["Aqark App",price.text ?? 0, downloadedImages[0],address.text ?? ""], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @objc func toogleFavorite()
    {
        if (coreDataViewModel!.isAdvertismentExist(id: self.advertisementId))
        {
            favButton.setImage( UIImage(named: "heart"), for: .normal)
            self.coreDataViewModel!.deleteAdvertismentFromFavourite(id: self.advertisementId)
        }else{
            if((coreDataViewModel?.checkNumberOfAdvertisment())!){
                favButton.setImage(UIImage(named: "red-heart"), for: .normal)
                self.coreDataViewModel!.addAdvertismentToFavourite(id: self.advertisementId)
                
            }else{
                let alert = UIAlertController(title: "Add To Favourite", message: "Can't add to favourite maximum 20 Ads can be added ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
