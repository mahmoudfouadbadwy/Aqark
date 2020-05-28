//
//  AdminAdvertisementData.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

extension AdminDataAccessLayer{
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
        let advertisementPropertyAddress = advertisementDictionary[AdvertisementKey.address] as! [String:Any]
        let advertisementPropertyLongitude = advertisementPropertyAddress[AdvertisementKey.longitude] as! String
        let advertisementPropertyLatitude = advertisementPropertyAddress[AdvertisementKey.latitude] as! String
        let advertisementPropertyLocation = advertisementPropertyAddress[AdvertisementKey.location] as! String
        let advertisementType = advertisementDictionary[AdvertisementKey.advertisementType] as! String
        let advertisementUserId = advertisementDictionary[AdvertisementKey.userId] as! String
        let advertisementPropertyAmenities = advertisementDictionary[AdvertisementKey.amenities] as? [String] ?? []
        let advertisementPropertyBathRooms = advertisementDictionary[AdvertisementKey.bathRooms] as! String
        let advertisementPropertyBeds = advertisementDictionary[AdvertisementKey.bedRooms] as! String
        let advertisementPropertyCountry = advertisementDictionary[AdvertisementKey.country] as! String
        let advertisementPropertyDate = advertisementDictionary[AdvertisementKey.date] as! String
        let advetisementPropertyDescription = advertisementDictionary[AdvertisementKey.description] as! String
        let advertisementPropertyImages = advertisementDictionary[AdvertisementKey.images] as? [String] ?? []
        let advertisementPayment = advertisementDictionary[AdvertisementKey.payment] as! String
        let advertisementPhone = advertisementDictionary[AdvertisementKey.phone] as! String
        let advertisementPropertyPrice = advertisementDictionary[AdvertisementKey.price] as! String
        let advertisementPropertyType = advertisementDictionary[AdvertisementKey.propertyType] as! String
        let advertisementPropertySize = advertisementDictionary[AdvertisementKey.size] as! String
        let advertisement = AdminAdvertisement(advertisementId: advertisementId, advertisementPropertyatitude: advertisementPropertyLatitude, advertisementPropertyLongitude: advertisementPropertyLongitude, advertisementPropertyLocation: advertisementPropertyLocation, advertisementType: advertisementType, advertisemetentUserId: advertisementUserId, advertisementPropertyAmenities: advertisementPropertyAmenities, advertisementPropertyBathRooms: advertisementPropertyBathRooms, advertisementPropertyBeds: advertisementPropertyBeds, advertisementCountry: advertisementPropertyCountry, advertisementDate: advertisementPropertyDate, advertisementPropertyDescription: advetisementPropertyDescription, advertismentsPropertyImages: advertisementPropertyImages, advertisementPayment: advertisementPayment, adevertisementPhone: advertisementPhone, advertisementPropertyPrice: advertisementPropertyPrice, advertisementPropertyType: advertisementPropertyType, advertisementPropertySize: advertisementPropertySize)
        return advertisement
    }
}
