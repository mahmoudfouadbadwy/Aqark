//
//  MocFavouriteDataAccess.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/10/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

@testable import Aqark

class MocFavouriteDataAccess{
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
    
    let userAdvertisements : [[String:Any]] = [["123":["445566","112233"]]]
    
    init() {
        advertisementsArray = [advertisement1,advertisement2]
    }

    func getAllFavouriteAdvertisements(completionForGetAllAdvertisements : @escaping (_ searchResults:[FavouriteModel],Int) -> Void){
        let advertismentCount = 0
        var advertisementsData = [FavouriteModel]()
       
        for advertisement in advertisementsArray{
           // advertisementsData.append(self.createAdvertisement(advertisements: advertisement))
        }
        completionForGetAllAdvertisements(advertisementsData, advertismentCount)
        
    }
    
    
    private func createAdvertisement(advertisements:[String:Any]) -> AdminAdvertisement{
        let advertisementId = advertisements.keys.first
        let advertisementDictionary = advertisements[advertisementId!] as! [String:Any]
        let advertisementPropertyAddress = advertisementDictionary[AdminAdvertisementKey.address] as! [String:Any]
        let advertisementPropertyLongitude = advertisementPropertyAddress[AdminAdvertisementKey.longitude] as! String
        let advertisementPropertyLatitude = advertisementPropertyAddress[AdminAdvertisementKey.latitude] as! String
        let advertisementPropertyLocation = advertisementPropertyAddress[AdminAdvertisementKey.location] as! String
        let advertisementType = advertisementDictionary[AdminAdvertisementKey.advertisementType] as! String
        let advertisementUserId = advertisementDictionary[AdminAdvertisementKey.userId] as! String
        let advertisementPropertyAmenities = advertisementDictionary[AdminAdvertisementKey.amenities] as? [String] ?? []
        let advertisementPropertyBathRooms = advertisementDictionary[AdminAdvertisementKey.bathRooms] as! String
        let advertisementPropertyBeds = advertisementDictionary[AdminAdvertisementKey.bedRooms] as! String
        let advertisementPropertyCountry = advertisementDictionary[AdminAdvertisementKey.country] as! String
        let advertisementPropertyDate = advertisementDictionary[AdminAdvertisementKey.date] as! String
        let advetisementPropertyDescription = advertisementDictionary[AdminAdvertisementKey.description] as! String
        let advertisementPropertyImages = advertisementDictionary[AdminAdvertisementKey.images] as? [String] ?? [""]
        let advertisementPayment = advertisementDictionary[AdminAdvertisementKey.payment] as! String
        let advertisementPhone = advertisementDictionary[AdminAdvertisementKey.phone] as! String
        let advertisementPropertyPrice = advertisementDictionary[AdminAdvertisementKey.price] as! String
        let advertisementPropertyType = advertisementDictionary[AdminAdvertisementKey.propertyType] as! String
        let advertisementPropertySize = advertisementDictionary[AdminAdvertisementKey.size] as! String
        let advertisement = AdminAdvertisement(advertisementId: advertisementId!, advertisementPropertyLatitude: advertisementPropertyLatitude, advertisementPropertyLongitude: advertisementPropertyLongitude, advertisementPropertyLocation: advertisementPropertyLocation, advertisementType: advertisementType, advertisemetentUserId: advertisementUserId, advertisementPropertyAmenities: advertisementPropertyAmenities, advertisementPropertyBathRooms: advertisementPropertyBathRooms, advertisementPropertyBeds: advertisementPropertyBeds, advertisementCountry: advertisementPropertyCountry, advertisementDate: advertisementPropertyDate, advertisementPropertyDescription: advetisementPropertyDescription, advertismentsPropertyImages: advertisementPropertyImages, advertisementPayment: advertisementPayment, adevertisementPhone: advertisementPhone, advertisementPropertyPrice: advertisementPropertyPrice, advertisementPropertyType: advertisementPropertyType, advertisementPropertySize: advertisementPropertySize)
        return advertisement
    }
    
}
