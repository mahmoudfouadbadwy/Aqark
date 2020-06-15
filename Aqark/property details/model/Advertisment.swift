//
//  Advertisment.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct Advertisment {
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
    
}


struct Agent{
    var name:String
    var company:String
    var rate:[String:Double]
}
