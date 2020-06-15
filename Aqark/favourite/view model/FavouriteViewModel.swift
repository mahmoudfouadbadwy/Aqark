//
//  FavouriteViewModel.swift
//  Aqark
//
//  Created by Mostafa Samir on 6/1/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

class FavouriteListViewModel{
    
    var favouritesViewModel : [FavouriteViewModel] = []
    var deletedAdsCount = 0
    private var dataAccess : FavouriteDataAccess!
    init(dataAccess : FavouriteDataAccess ) {
        self.dataAccess = dataAccess
    }
    
    func populateAds(completionForGetAllAdvertisements : @escaping (_ searchResults:[FavouriteViewModel],Int) -> Void){
        dataAccess.getAllFavouriteAdvertisements(){(favResults,deletedCount) in
            self.favouritesViewModel = favResults.map{ ad in
                FavouriteViewModel(model: ad)
            }
            self.deletedAdsCount=deletedCount
            completionForGetAllAdvertisements(self.favouritesViewModel, self.deletedAdsCount)
        }
    }
    
    func removeFavObserver(){
        self.dataAccess.removeFavouriteObserver()
        self.dataAccess=nil
    }
}

struct FavouriteViewModel{
    var image: String!
    var propertyType: String!
    var price: Double!
    var address: String!
    var country: String!
    var size: String!
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
    }
}

struct FavoriteNetworking{
  static func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}

