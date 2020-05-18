//
//  PropertyDetailViewModel.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class PropertyDetailViewModel {
    var adverisementViewModel :[AdverisementViewModel] = [AdverisementViewModel]()
    private var propertyDataAccess:PropertyDetailDataAccess
    
    init(propertyDataAccess :PropertyDetailDataAccess) {
        self.propertyDataAccess = propertyDataAccess
    }
    
     func populateAdvertisement(completionForPopulateAd : @escaping (_ adResult:[AdverisementViewModel]) -> Void){
        propertyDataAccess.gatDataFromFirebase(){(searchResult) in
        self.adverisementViewModel = searchResult.map { ad in
            AdverisementViewModel(advertise: ad)
        
        }
            completionForPopulateAd(self.adverisementViewModel)
        }
    }
    
}

class AdverisementViewModel {
 
    var userID:String!
    var advertismentType:String!
    var bathroom:String!
    var propertyType:String!
    var bedroom:String!
    var country:String!
    var date:String!
    var description:String!
    var phone:String!
    var price:String!
    var propertysize:String!
    var latitude:String!
    var longitude:String!
    var location:String!
    var amenities:[String]!
    var images:[String]!
 //   var advertisementId:String!
    
    init(advertise:Advertisment){
        self.userID=advertise.userID
        self.advertismentType=advertise.advertismentType
        self.propertyType=advertise.propertyType
        self.bathroom=advertise.bathroom
        self.bedroom=advertise.bedroom
        self.country=advertise.country
        self.date=advertise.date
        self.description=advertise.description
        self.phone=advertise.phone
        self.price=advertise.price
        self.propertysize=advertise.size
        self.latitude=advertise.latitude
        self.longitude=advertise.longitude
        self.location=advertise.location
        self.amenities=advertise.amenities
        self.images=advertise.images
    //    self.advertisementId=advertise.advertismentID
    }
   
}
