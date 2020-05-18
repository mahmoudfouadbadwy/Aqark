//
//  AdvertisementData .swift
//  Aqark
//
//  Created by shorouk mohamed on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import SDWebImage

class AdvertisementData{
    
    var advertisementsData = [AdvertisementSearchModel]()
    var advertisementImage : String!
    var advertisementPropertyType : String!
    var advertisementType : String!
    var advertisementId  : String!
    var advertisementAddress : String!
    var advertisementCountry : String!
    var advertisementPropertySize : String!
    var advertisementBedRoomsNum : String!
    var advertisementBathRoomsNum : String!
    var advertisementPropertyPrice : String!
    var advertisementPropertyLocation : String!
    var addressDictionary: [String: String] = [:]
    
    func getAllAdvertisements(completionForGetAllAdvertisements : @escaping (_ searchResults:[AdvertisementSearchModel]) -> Void){
        
        let ref = Database.database().reference()
        ref.child("Advertisements").observe(.value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = child.value as? [String : Any]
                let key = child.key as Any
                

//
                let images = dict!["images"] as? [Any]
//                for index in 0...images!.count - 1 {
                self.advertisementImage = images?[0] as? String ?? "search_apartment"
//                 print(self.advertisementImage)
//                }
                
                self.advertisementPropertyType = dict?["propertyType"] as? String ?? "Not Applied"
                self.advertisementType = dict?["Advertisement Type"] as? String ?? "Not Applied"
                self.advertisementCountry = dict?["country"] as? String ?? "Not Applied"
                self.advertisementId = key as? String
                self.advertisementPropertySize = dict?["size"] as? String ?? "Not Applied"
                self.advertisementBedRoomsNum = dict?["bedRooms"] as? String ?? "Not Applied"
                self.advertisementBathRoomsNum = dict?["bathRooms"] as? String ?? "Not Applied"
                self.advertisementPropertyPrice = dict?["price"] as? String ?? "Not Applied"
                
                if var unwrappedAddressDict = dict?["Address"] {
                     unwrappedAddressDict = dict?["Address"] as! [String : String]
                    self.addressDictionary = unwrappedAddressDict as! [String : String]
                    self.advertisementPropertyLocation = self.addressDictionary["location"] ?? "Not Applied"
                }else{
                    self.advertisementPropertyLocation = "Not Applied"
                }

                self.advertisementsData.append(AdvertisementSearchModel(
                    image: self.advertisementImage, propertyType  : self.advertisementPropertyType,
                    advertisementType: self.advertisementType,
                    advertisementId: self.advertisementId,
                    price: self.advertisementPropertyPrice,
                    address: self.advertisementPropertyLocation,
                    country: self.advertisementCountry,
                    size: self.advertisementPropertySize,
                    bedRoomsNumber: self.advertisementBedRoomsNum,
                    bathRoomsNumber:  self.advertisementBathRoomsNum))
             
                completionForGetAllAdvertisements(self.advertisementsData)
            }
        })
    }
}



