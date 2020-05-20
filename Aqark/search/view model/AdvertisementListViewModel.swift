//
//  SearchViewModel.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

class AdvertisementListViewModel{
    
    var advertismentsViewModel : [AdvertisementViewModel] = [AdvertisementViewModel]()
    private var dataAccess : AdvertisementData
    
    init(dataAccess : AdvertisementData ) {
        self.dataAccess = dataAccess
    }
    
    func populateAds(completionForPopulateAds : @escaping (_ adsResults:[AdvertisementViewModel]) -> Void){
        AdvertisementData().getAllAdvertisements(){(searchResults) in
        self.advertismentsViewModel = searchResults.map{ ad in
            AdvertisementViewModel(model: ad)
        }
        completionForPopulateAds(self.advertismentsViewModel )
    }
    }
}

class AdvertisementViewModel{
    
    var image: String!
    var propertyType: String!
    var price: String!
    var address: String!
    var country: String!
    var size: String!
    var bedRoomsNumber: String!
    var bathRoomsNumber: String!
    var advertisementId : String!
    var advertisementType : String!

    init(model : AdvertisementSearchModel){
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
        
            }
}

