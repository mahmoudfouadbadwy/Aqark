//
//  FavouriteViewModel.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

class FavouriteListViewModel{
    
    var favouriteViewModel : [FavouriteViewModel] = [FavouriteViewModel]()
    private var dataAccess : FavouriteDataAccess
    
    init(dataAccess : FavouriteDataAccess ) {
        self.dataAccess = dataAccess
    }
    
    func populateAds(completionForPopulateAds : @escaping (_ adsResults:[FavouriteViewModel]) -> Void){
        FavouriteDataAccess().getAllFavouriteAdvertisements(){(searchResults) in
            self.favouriteViewModel.removeAll()
            self.favouriteViewModel = searchResults.map{ ad in
                //print("  searchResults  \(ad)")
                FavouriteViewModel(model: ad)
               
                }
            print("  searchResults  \(self.favouriteViewModel)")
            completionForPopulateAds(self.favouriteViewModel )
        }
    }
}

class FavouriteViewModel{
    var image: String!
    var propertyType: String!
    var price: Double!
    var address: String!
    var country: String!
    var size: String!
    var longtiude : Double!
    var latitude : Double!
    var bedRoomsNumber: String!
    var bathRoomsNumber: String!
    var advertisementId : String!
    var advertisementType : String!
    var advertisementDate : String!
    
    init(model : FavouriteModel){
        self.image = model.image
        self.propertyType = model.propertyType
        self.price = model.price
        self.address = model.address
        self.country = model.country
        self.size = model.size
        self.bedRoomsNumber = model.bedRoomsNumber
        self.bathRoomsNumber = model.bathRoomsNumber
        self.advertisementId = model.advertisementId
        self.advertisementType = model.advertisementType
        self.advertisementDate = model.date
        self.latitude = Double(model.latitude)
        self.longtiude = Double(model.longtiude)
    }
}

