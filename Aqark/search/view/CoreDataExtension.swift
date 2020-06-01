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
    
    func setFavouriteButton (btn: UIButton,id: String){
        let storedIds = coreDataViewModel?.getAllFavouriteAdvertisment()
        if (storedIds!.count != 0){
            for advertismentID in storedIds!{
                if(advertismentID.elementsEqual(id)){
                    btn.tintColor = UIColor.red
                }else{
                    btn.tintColor = UIColor.lightGray
                }
            }
        }

    }
    
        func addToFav(favButton: UIButton) {
            print("  button id \(favButton.titleLabel?.text)")
            
            if (favButton.tintColor == UIColor.red){
                
                favButton.tintColor = UIColor.lightGray
                self.coreDataViewModel!.deleteAdvertismentFromFavourite(id:(favButton.titleLabel?.text)!)
            }else{
                if((coreDataViewModel?.checkNumberOfAdvertisment())!){
                    favButton.tintColor = UIColor.red
                    self.coreDataViewModel!.addAdvertismentToFavourite(id: (favButton.titleLabel?.text)!)
                    print("  count \(coreDataViewModel?.getAllFavouriteAdvertisment().count)")
                }else{
                    let alert = UIAlertController(title: "Add To Favourite", message: "Can't add to favourite maximum 20 Ads can be added ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
   }
}
