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
    
    func addToFav(favButton: UIButton) {

        if isFiltering{
            
            if (coreDataViewModel?.checkFav(id: filteredAdsList[favButton.tag].advertisementId!) != 0){
                favButton.tintColor = UIColor.lightGray
                
            self.coreDataViewModel!.deleteFromFavou(id:filteredAdsList[favButton.tag].advertisementId!)
            }else{
                favButton.tintColor = UIColor.red
                
                self.coreDataViewModel!.addPropertyToFavourite(id: filteredAdsList[favButton.tag].advertisementId!)
            }
            
        }else{
        
            guard let advertisment = arrOfAdViewModel?[favButton.tag] else { return }

            if (coreDataViewModel?.checkFav(id: advertisment.advertisementId!) != 0){
                favButton.tintColor = UIColor.lightGray
                
                self.coreDataViewModel!.deleteFromFavou(id: (advertisment.advertisementId))
    
            }else{
                favButton.tintColor = UIColor.red
                
                self.coreDataViewModel!.addPropertyToFavourite(id: (advertisment.advertisementId))
            }
       
        }
    }
    
    
}
