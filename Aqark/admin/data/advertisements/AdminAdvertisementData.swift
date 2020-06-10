//
//  AdminAdvertisementData.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

extension AdminDataAccess{
    
    func getAdvertisements(completionForGetAdvertisements:@escaping(_ advertisementsData : [AdminAdvertisement]) -> Void){
        var advertisements = [AdminAdvertisement]()
        let advertisementsRef = ref.child("Advertisements")
        advertisementsRef.observe(.value) { (snapShot) in
            advertisements.removeAll()
            for child in snapShot.children.allObjects as! [DataSnapshot]{
                advertisements.append(self.createAdvertisement(child: child))
            }
            completionForGetAdvertisements(advertisements)
        }
    }
    
    private func createAdvertisement(child:DataSnapshot) -> AdminAdvertisement{
        let advertisementId = child.key
        let advertisementDictionary = child.value as! [String:Any]
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
        let advertisement = AdminAdvertisement(advertisementId: advertisementId, advertisementPropertyLatitude: advertisementPropertyLatitude, advertisementPropertyLongitude: advertisementPropertyLongitude, advertisementPropertyLocation: advertisementPropertyLocation, advertisementType: advertisementType, advertisemetentUserId: advertisementUserId, advertisementPropertyAmenities: advertisementPropertyAmenities, advertisementPropertyBathRooms: advertisementPropertyBathRooms, advertisementPropertyBeds: advertisementPropertyBeds, advertisementCountry: advertisementPropertyCountry, advertisementDate: advertisementPropertyDate, advertisementPropertyDescription: advetisementPropertyDescription, advertismentsPropertyImages: advertisementPropertyImages, advertisementPayment: advertisementPayment, adevertisementPhone: advertisementPhone, advertisementPropertyPrice: advertisementPropertyPrice, advertisementPropertyType: advertisementPropertyType, advertisementPropertySize: advertisementPropertySize)
        return advertisement
    }
}
