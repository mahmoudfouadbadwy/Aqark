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
    var price :Double!
    var size :String!
    var latitude :String!
    var longitude :String!
    var location :String!
    var amenities :[String]!
    var images :[String]!
    init(userID :String, advertismentType :String, propertyType :String, bathroom :String, bedroom :String, country :String, date :String, description :String, phone :String, price :Double, size :String, latitude :String,longitude :String , location :String,amenities :[String], images :[String]) {
        self.userID = userID
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
        self.latitude = latitude
        self.longitude = longitude
        self.location = location
        self.amenities = amenities
        self.images = images
        self.images = images
    }
}


struct Agent{
    var name:String
    var company:String
    var rate:Double
}
