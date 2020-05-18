//
//  SearchModel.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdvertisementSearchModel {
    var image: String!
    var propertyType: String!
    var advertisementType: String!
    var advertisementId: String!
    var price: String!
    var address: String!
    var country: String!
    var size: String!
    var bedRoomsNumber: String!
    var bathRoomsNumber: String!
    
    
    init(image: String, propertyType: String,advertisementType: String ,advertisementId: String,price: String, address: String, country: String, size: String, bedRoomsNumber: String,bathRoomsNumber: String){
       self.image = image
        self.propertyType = propertyType
        self.advertisementId = advertisementId
        self.price = price
        self.address = address
        self.country = country
        self.size = size
        self.bedRoomsNumber = bedRoomsNumber
        self.bathRoomsNumber = bathRoomsNumber
        self.advertisementType = advertisementType
       
    }
    }
