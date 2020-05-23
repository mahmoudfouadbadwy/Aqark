//
//  AdminDataAccessLayer.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
class AdminDataAccessLayer{
    
    var ref = Database.database().reference()
    
    func getUsers(completionForGetUsers : @escaping(_ usersData : [AdminUser]) -> Void){
        var users = [AdminUser]()
        let usersRef = ref.child("Users")
        usersRef.observe(.value) { (snapShot) in
            for child in snapShot.children.allObjects as! [DataSnapshot]{
                users.append(self.createUser(child: child))
            }
            completionForGetUsers(users)
        }
    }
    
    func getAdvertisements(completionForGetAdvertisements:@escaping(_ advertisementsData : [AdminAdvertisement]) -> Void){
        var advertisements = [AdminAdvertisement]()
        let advertisementsRef = ref.child("Advertisements")
        advertisementsRef.observe(.value) { (snapShot) in
            for child in snapShot.children.allObjects as! [DataSnapshot]{
                advertisements.append(self.createAdvertisement(child: child))
            }
            completionForGetAdvertisements(advertisements)
        }
    }
    
    private func createUser(child:DataSnapshot) -> AdminUser{
        let userId = child.key
        let userDictionary = child.value as! [String : Any]
        let userName = userDictionary[UserKey.userName] as! String
        let userEmail = userDictionary[UserKey.userEmail] as! String
        let userPhone = userDictionary[UserKey.userPhone] as? String ?? "No Phone"
        let userCountry = userDictionary[UserKey.userCountry] as? String ?? "No Country"
        let userCompany = userDictionary[UserKey.userCompany] as? String ?? "No Company"
        let userRole = userDictionary[UserKey.userRole] as! String
        let userExperience = "4"
        let userRating = "4"
        let userImage = "https://cdn1.vectorstock.com/i/1000x1000/26/40/profile-placeholder-image-gray-silhouette-no-vector-22122640.jpg"
        let user = AdminUser(userId:userId, userName: userName, userEmail: userEmail, userPhone: userPhone, userCountry: userCountry, userCompany: userCompany, userRole: userRole, userRating: userRating, userExperience: userExperience, userImage: userImage)
        return user
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
        let advertisementPropertyAmenities = advertisementDictionary[AdvertisementKey.amenities] as! [String]
        let advertisementPropertyBathRooms = advertisementDictionary[AdvertisementKey.bathRooms] as! String
        let advertisementPropertyBedRooms = advertisementDictionary[AdvertisementKey.bedRooms] as! String
        let advertisementPropertyCountry = advertisementDictionary[AdvertisementKey.country] as! String
        let advertisementPropertyDate = advertisementDictionary[AdvertisementKey.date] as! String
        let advetisementPropertyDescription = advertisementDictionary[AdvertisementKey.description] as! String
        let advertisementPropertyImages = advertisementDictionary[AdvertisementKey.images] as! [String]
        let advertisementPayment = advertisementDictionary[AdvertisementKey.payment] as! String
        let advertisementPhone = advertisementDictionary[AdvertisementKey.phone] as! String
        let advertisementPropertyPrice = advertisementDictionary[AdvertisementKey.price] as! String
        let advertisementPropertyType = advertisementDictionary[AdvertisementKey.propertyType] as! String
        let advertisementPropertySize = advertisementDictionary[AdvertisementKey.size] as! String
        let advertisement = AdminAdvertisement(advertisementId: advertisementId, advertisementPropertyatitude: advertisementPropertyLatitude, advertisementPropertyLongitude: advertisementPropertyLongitude, advertisementPropertyLocation: advertisementPropertyLocation, advertisementType: advertisementType, advertisemetentUserId: advertisementUserId, advertisementPropertyAmenities: advertisementPropertyAmenities, advertisementPropertyBathRooms: advertisementPropertyBathRooms, advertisementPropertyBedRoom: advertisementPropertyBedRooms, advertisementCountry: advertisementPropertyCountry, advertisementDate: advertisementPropertyDate, advertisementPropertyDescription: advetisementPropertyDescription, advertismentsPropertyImages: advertisementPropertyImages, advertisementPayment: advertisementPayment, adevertisementPhone: advertisementPhone, advertisementPropertyPrice: advertisementPropertyPrice, advertisementPropertyType: advertisementPropertyType, advertisementPropertySize: advertisementPropertySize)
        return advertisement
    }}
