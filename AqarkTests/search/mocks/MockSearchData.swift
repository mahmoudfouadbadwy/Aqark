
//
//  Mocks.swift
//  AqarkTests
//
//  Created by Shorouk Mohamed on 6/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//


import Foundation
@testable import Aqark

class MockSearchData{
    var advertisementsArray : [[String : Any]]
    let advertisement1 : [String : Any] = ["112233":
        ["Address":["latitude":"31.76","longitude":"33.11","location":"Mansoura"],
         "Advertisement Type":"Rent",
         "UserId":"123",
         "amenities":[""],
         "bathRooms":"1",
         "bedRooms":"1",
         "country":"Mansoura",
         "date":"2020",
         "description":"Nice",
         "images":[""],
         "payment":"free",
         "phone":"111",
         "price":"150",
         "propertyType":"Room",
         "size":"100"]]
    
    let advertisement2 : [String : Any] = ["445566":
        ["Address":["latitude":"40.40","longitude":"35.35","location":"Cairo"],
         "Advertisement Type":"Buy",
         "UserId":"456",
         "amenities":[""],
         "bathRooms":"2",
         "bedRooms":"2",
         "country":"Cairo",
         "date":"2020",
         "description":"Beautiful",
         "images":[""],
         "payment":"free",
         "phone":"222",
         "price":"150",
         "propertyType":"Apartment",
         "size":"20000"]]
    
    
    init() {
        advertisementsArray = [advertisement1,advertisement2]
    }
    
    func getAllAdvertisements(completionForGetAdvertisements:@escaping(_ advertisementsData : [AdvertisementSearchModel]) -> Void){
        var advertisements = [AdvertisementSearchModel]()
        for child in advertisementsArray{
            advertisements.append(self.createAdvertisementSearchModel(dict: child))
        }
        completionForGetAdvertisements(advertisements)
    }


func createAdvertisementSearchModel(dict : [String : Any]?)-> AdvertisementSearchModel{
    let advertisementId = dict?.keys.first
    let advertisementDict = dict![advertisementId!] as! [String : Any]
    let images = advertisementDict["images"] as? [Any]
    let advertisementImage = images?[0] as? String ?? "NoImage"
    let advertisementPropertyType = advertisementDict["propertyType"] as? String ?? "Not Applied"
    let advertisementType = advertisementDict["Advertisement Type"] as? String ?? "Not Applied"
    let advertisementCountry = advertisementDict["country"] as? String ?? "Not Applied"
    let advertisementPropertySize = advertisementDict["size"] as? String ?? "Not Applied"
    let advertisementDate = advertisementDict["date"] as? String ?? "Not Applied"
    let advertisementBedRoomsNum = advertisementDict["bedRooms"] as? String ?? "Not Applied"
    let advertisementBathRoomsNum = advertisementDict["bathRooms"] as? String ?? "Not Applied"
    let advertisementPropertyPrice = Localization.convertNumbers(lang: "lang".localize, stringNumber: (dict?["price"] as? String) ?? "0").0.stringValue
    var advertisementPropertyLocation = ""
    var advertisementPropertyLatitude = ""
    var advertisementPropertyLongtiude = ""
    if var unwrappedAddressDict = advertisementDict["Address"] {
        unwrappedAddressDict = advertisementDict["Address"] as! [String : String]
        let addressDictionary = unwrappedAddressDict as! [String : String]
        advertisementPropertyLocation = addressDictionary["location"] ?? "Not Applied"
        advertisementPropertyLatitude = addressDictionary["latitude"] ?? "0.0"
        advertisementPropertyLongtiude = addressDictionary["longitude"] ?? "0.0"
    }else{
        advertisementPropertyLocation = "Not Applied"
    }
    
    return AdvertisementSearchModel(
        image: advertisementImage, propertyType  : advertisementPropertyType,
        advertisementType: advertisementType,
        advertisementId: advertisementId,
        price: Double(advertisementPropertyPrice),
        address: advertisementPropertyLocation,
        country: advertisementCountry,
        size: advertisementPropertySize,
        bedRoomsNumber: advertisementBedRoomsNum,
        bathRoomsNumber: advertisementBathRoomsNum,
        date : advertisementDate,
        longtiude: Double(advertisementPropertyLongtiude),
        latitude: Double(advertisementPropertyLatitude)
    )
    
    
}

}



