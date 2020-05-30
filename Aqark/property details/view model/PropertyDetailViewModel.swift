//
//  PropertyDetailViewModel.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class PropertyDetailViewModel {
     var propertyDataAccess:PropertyDetailDataAccess
    init(propertyDataAccess :PropertyDetailDataAccess) {
        self.propertyDataAccess = propertyDataAccess
    }
    
    func populateAdvertisement(id:String,completion:@escaping(AdverisementViewModel,AgentViewModel)->Void){
        propertyDataAccess.gatAdvertisementDetialby(id: id) { (advertisemant,user) in
            completion(AdverisementViewModel(advertisement: advertisemant),AgentViewModel(agent: user))
        }
    }
}

class AdverisementViewModel{
    
    var userID:String!
    var advertismentType:String!
    var bathroom:String!
    var propertyType:String!
    var bedroom:String!
    var country:String!
    var date:String!
    var description:String!
    var phone:String!
    var price:Double!
    var propertysize:String!
    var latitude:String!
    var longitude:String!
    var location:String!
    var amenities:[String]!
    var images:[String]!
    
    init(advertisement:Advertisment){
        self.userID = advertisement.userID
        self.advertismentType=advertisement.advertismentType
        self.propertyType=advertisement.propertyType
        self.bathroom=advertisement.bathroom
        self.bedroom=advertisement.bedroom
        self.country=advertisement.country
        self.date=advertisement.date
        self.description=advertisement.description
        self.phone=advertisement.phone
        self.price=advertisement.price
        self.propertysize=advertisement.size
        self.latitude=advertisement.latitude
        self.longitude=advertisement.longitude
        self.location=advertisement.location
        self.amenities=advertisement.amenities
        self.images=advertisement.images
    }
}
    
class AgentViewModel
{
    var username:String!
    var company:String!
    var rate:Double!
    
    init(agent:Agent) {
        self.username = agent.name
        self.company = agent.company
        self.rate = agent.rate
    }
}
