//
//  CoreDataExtension.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/22/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension SearchViewController:FavouriteProtocol{
    
    func setupCoredata (){
        self.coreDataViewModel=CoreDataViewModel(dataAccess: CoreDataAccess())
    }
    
    func addToFav(favButton: UIButton) {
        if (coreDataViewModel!.isAdvertismentExist(id: (favButton.titleLabel?.text)!))
        {
            favButton.image("heart")
            self.coreDataViewModel!.deleteAdvertismentFromFavourite(id:(favButton.titleLabel?.text)!)
        }else{
            if((coreDataViewModel?.checkNumberOfAdvertisment())!){
               
               favButton.image("red-heart")
                self.coreDataViewModel!.addAdvertismentToFavourite(id: (favButton.titleLabel?.text)!)
            }else{
                let alert = UIAlertController(title: "Add To Favourite".localize, message: "Can't add to favourite maximum 20 Ads can be added ".localize, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel".localize, style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
