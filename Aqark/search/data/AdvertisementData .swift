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

class AdvertisementData{
    
    var advertisementsData = [AdvertisementSearchModel]()
    var advertisementImage : UIImage!
    var advertisementPropertyType : String!
    var advertisementType : String!
    var advertisementId  : String!
    var advertisementAddress : String!
    var advertisementCountry : String!
    var advertisementPropertySize : Int!
    var advertisementBedRoomsNum : Int!
    var advertisementBathRoomsNum : Int!
    var advertisementPropertyPrice : Int!
    var advertisementPropertyLocation : String!
    
    func getAllAdvertisements(completionForGetAllAdvertisements : @escaping (_ searchResults:[AdvertisementSearchModel]) -> Void){
        
        let ref = Database.database().reference()
        ref.child("Advertisements").observe(.value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = child.value as? [String : Any]
                let key = child.key as? Any
                
                //self.pimages = dict["images"] as! UIImage
                self.advertisementPropertyType = dict!["property type"] as? String
                self.advertisementType = dict!["Advertisement Type"] as? String
                self.advertisementCountry = dict!["country"] as? String
                self.advertisementId = key as? String
                self.advertisementPropertySize = dict!["size"] as? Int
                self.advertisementBedRoomsNum = dict!["bedRooms"] as? Int
                self.advertisementBathRoomsNum = dict!["bathRooms"] as? Int
                self.advertisementPropertyPrice = dict!["price"] as? Int
                var addressDictionary = dict!["Address"]  as! [String : AnyObject]
                self.advertisementPropertyLocation = addressDictionary["location"] as? String
                
                self.advertisementsData.append(AdvertisementSearchModel(
                    image: UIImage(named: "search_apartment")!,
                    propertyType: self.advertisementPropertyType,
                    advertisementType: self.advertisementType,
                    advertisementId: self.advertisementId,
                    price: String(self.advertisementPropertyPrice),
                    address: self.advertisementPropertyLocation,
                    country: self.advertisementCountry,
                    size: String(self.advertisementPropertySize),
                    bedRoomsNumber: String(self.advertisementBedRoomsNum),
                    bathRoomsNumber: String( self.advertisementBathRoomsNum)))
             
                completionForGetAllAdvertisements(self.advertisementsData)
            }
        })
    }
}



