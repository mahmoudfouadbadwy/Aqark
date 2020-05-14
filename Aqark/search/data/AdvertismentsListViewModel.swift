//
//  SearchViewModel.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

class AdvertismentsListViewModel{
    
    var advertismentsViewModel : [AdvertisementViewModel] = [AdvertisementViewModel]()
    private var data : AdvertisementData
    
    init(data : AdvertisementData ) {
        self.data = data
        populateAds()
    }
    
    
    private func populateAds(){
        
        let ads = AdvertisementData.getAllAdvertisements()
        self.advertismentsViewModel = ads.map{ ad in
            return AdvertisementViewModel(model: ad)
        }
    }
}

class AdvertisementViewModel{
    
    var image: UIImage!
    var propertyType: String!
    var price: String!
    var address: String!
    var country: String!
    var size: String!
    var bedRoomsNumber: String!
    var bathRoomsNumber: String!

    init(model : SearchModel){
        self.image = model.image
        self.propertyType = model.propertyType
        self.price = model.price
        self.address = model.address
        self.country = model.country
        self.size = model.size
        self.bedRoomsNumber = model.bedRoomsNumber
        self.bathRoomsNumber = model.bathRoomsNumber
        
            }
    
}
