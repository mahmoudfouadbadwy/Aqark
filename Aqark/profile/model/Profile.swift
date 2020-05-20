//
//  Profile.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
struct Profile{
    var role:String
    var picture:String
    var username:String
    var email:String
    var country:String
    var address:String
    var company:String
    var phone:String
}

struct AdvertismentsStore {
    var allAdvertisements :[ProfileAdvertisement] = []
    mutating func addAdvertisement( _ advertisement:ProfileAdvertisement)
    {
       allAdvertisements.append(advertisement)
    }
}

struct ProfileAdvertisement {
    var propertyType:String
    var price:String
    var address:String
    var bed:String
    var bathroom:String
    var propertySize:String
}
