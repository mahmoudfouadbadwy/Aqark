//
//  Agent.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
struct AgentAdvertismentsStore {
    var allAdvertisements :[AgentAdvertisement] = []
    mutating func addAdvertisement( _ advertisement:AgentAdvertisement)
    {
        allAdvertisements.append(advertisement)
    }
}

struct AgentAdvertisement {
    var propertyType:String
    var price:Double
    var address:String
    var bed:String
    var bathroom:String
    var propertySize:String
    var propertyImage:String
    var paymentType:String
    var advertisementType:String
    var advertisementId:String
}
