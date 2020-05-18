//
//  Advertisment.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class Advertisment {
    var userID :String!
    var advertismentType :String!
    var propertyType :String!
    var bathroom :String!
    var bedroom :String!
    var country :String!
    var date :String!
    var description :String!
    var phone :String!
    var price :String!
    var size :String!
  //  var views :String!
    var latitude :String!
    var longitude :String!
    var location :String!
    var amenities :[String]!
    var images :[String]!
  //  var advertismentID :String!
    
    
    init(userID :String, advertismentType :String, propertyType :String, bathroom :String, bedroom :String, country :String, date :String, description :String, phone :String, price :String, size :String, latitude :String,longitude :String , location :String,amenities :[String], images :[String]) {
        self.advertismentType = advertismentType
        self.propertyType = propertyType
        self.bathroom = bathroom
        self.bedroom = bedroom
        self.country = country
        self.date = date
        self.description = description
        self.phone = phone
        self.price = price
        self.size = size
 //       self.views = views
        self.latitude = latitude
        self.longitude = longitude
       self.location = location
        self.amenities = amenities
        self.images = images
        self.images = images
       // self.advertismentID = advertismentID
    }
    
    
}
