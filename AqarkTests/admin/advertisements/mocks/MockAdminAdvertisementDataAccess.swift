//
//  MockAdminAdvertisementDataAccess.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/7/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
@testable import Aqark

class MockAdminAdvertisementDataAccess{
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
    
    func getAdvertisements(completionForGetAdvertisements:@escaping(_ advertisementsData : [AdminAdvertisement]) -> Void){
        var advertisements = [AdminAdvertisement]()
        for child in advertisementsArray{
            advertisements.append(self.createAdvertisement(child: child))
        }
        completionForGetAdvertisements(advertisements)
    }
    
    private func createAdvertisement(child:[String:Any]) -> AdminAdvertisement{
        let advertisementId = child.keys.first
        let advertisementDictionary = child[advertisementId!] as! [String:Any]
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
    
    func deleteAdvertisment(adminAdvertisement:AdminAdvertisementViewModel,completionForDeleteAdvertisement:@escaping(_ deleted:Bool)->Void){
        deleteFromUsersAds(by: adminAdvertisement.advertisementUserId, and: adminAdvertisement.advertisementId){(deleted)in
            if(deleted){
                self.deleteFromAdvertisements(by: adminAdvertisement.advertisementId)
                completionForDeleteAdvertisement(true)
            }else{
                completionForDeleteAdvertisement(false)
            }
        }
    }
    
    private func deleteFromUsersAds(by userID : String,and advertisementID : String,completion:@escaping(_ deleted:Bool)->Void)
    {
        var deleted = false
        for user in userAdvertisements{
            var userAdvertisement = user[userID] as? [String]
            for i in 0...userAdvertisement!.count - 1{
                let advertisement = userAdvertisement![i]
                if(advertisement == advertisementID){
                    userAdvertisement!.remove(at: i)
                    deleted = true
                    break
                }
            }
        }
        completion(deleted)
    }
    
    private func deleteFromAdvertisements(by advertisementID:String)
    {
        for i in 0...advertisementsArray.count - 1{
            let advertisement = advertisementsArray[i]
            if (advertisement.keys.first == advertisementID){
                advertisementsArray.remove(at: i)
                break
            }
        }
    }
}
