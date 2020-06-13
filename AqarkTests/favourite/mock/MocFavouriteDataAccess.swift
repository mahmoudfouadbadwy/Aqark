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
    var storedAdvertisementsArray : [String]!
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
    
    let advertisment2 : [String : Any] = ["445566":
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
        advertisementsArray = [advertisement1,advertisment2]
        storedAdvertisementsArray = ["112233","445566","445577"]
    }
    
    func deleteFavouriteAdsFromCoredata (id: String)->Bool{
        var flag = false
        if(storedAdvertisementsArray.contains(where: { (ad) -> Bool in
            ad == id
        })){
            print("delete successed")
            flag = true
        }else{
            print("delete failed")
        }
        return flag
    }
    
    func getAllFavouriteAdvertisements(completionForGetAllAdvertisements : @escaping (_ searchResults:[FavouriteModel],Int) -> Void){
        var advertismentCount = 0
        var advertisementsData = [FavouriteModel]()
        
        if (storedAdvertisementsArray.count != 0){
            for advertisement in storedAdvertisementsArray {
                var advertis:[String : Any]!
                if(advertisementsArray.contains(where: { (ad) -> Bool in
                    advertis=ad
                    return ad.keys.first == advertisement
                })){
                advertisementsData.append(self.createAdvertisementSearchModel(dict: advertis, key: advertisement))
                }else{
                
                advertismentCount += 1
                self.deleteFavouriteAdsFromCoredata(id: advertisement)
            }
            if (advertismentCount + advertisementsData.count == storedAdvertisementsArray.count){
                completionForGetAllAdvertisements(advertisementsData,advertismentCount)
            }
            }
        }
        
    }
    
    func createAdvertisementSearchModel(dict : [String : Any]?, key : String)-> FavouriteModel{
        let images = dict!["images"] as? [Any]
        let advertisementImage = images?[0] as? String ?? "NoImage"
        let advertisementPropertyType = dict?["propertyType"] as? String ?? "Not Applied"
        let advertisementType = dict?["Advertisement Type"] as? String ?? "Not Applied"
        let advertisementCountry = dict?["country"] as? String ?? "Not Applied"
        let advertisementId = key
        let advertisementPropertySize = dict?["size"] as? String ?? "Not Applied"
        let advertisementDate = dict?["date"] as? String ?? "Not Applied"
        let advertisementBedRoomsNum = dict?["bedRooms"] as? String ?? "Not Applied"
        let advertisementBathRoomsNum = dict?["bathRooms"] as? String ?? "Not Applied"
        let advertisementPropertyPrice = Localization.convertNumbers(lang: "lang".localize, stringNumber: (dict?["price"] as? String) ?? "0").0.stringValue
        let advertisementPropertyLocation:String!
        if var unwrappedAddressDict = dict?["Address"] {
            unwrappedAddressDict = dict?["Address"] as! [String : String]
            let addressDictionary = unwrappedAddressDict as! [String : String]
            advertisementPropertyLocation = addressDictionary["location"] ?? "Not Applied"
            _ = addressDictionary["latitude"] ?? "0.0"
            _ = addressDictionary["longitude"] ?? "0.0"
        }else{
            advertisementPropertyLocation = "Not Applied"
        }
        return FavouriteModel(
            image: advertisementImage, propertyType  : advertisementPropertyType,
            advertisementType: advertisementType,
            advertisementId: advertisementId,
            price: Double(advertisementPropertyPrice),
            address: advertisementPropertyLocation,
            country: advertisementCountry,
            size: advertisementPropertySize,
            bedRoomsNumber: advertisementBedRoomsNum,
            bathRoomsNumber:  advertisementBathRoomsNum,
            date : advertisementDate
        )
    }
    
}
