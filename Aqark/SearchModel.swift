//
//  SearchModel.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class SearchModel {
    var image: UIImage!
    var propertyType: String!
    var advertisementType: String!
    var price: String!
    var address: String!
    var country: String!
    var size: String!
    var bedRoomsNumber: String!
    var bathRoomsNumber: String!
    
    
    init(image: UIImage, propertyType: String,advertisementType: String ,price: String, address: String, country: String, size: String, bedRoomsNumber: String,bathRoomsNumber: String){
       self.image = image
        self.propertyType = propertyType
        self.price = price
        self.address = address
        self.country = country
        self.size = size
        self.bedRoomsNumber = bedRoomsNumber
        self.bathRoomsNumber = bathRoomsNumber
        self.advertisementType = advertisementType
       
    }
    }
