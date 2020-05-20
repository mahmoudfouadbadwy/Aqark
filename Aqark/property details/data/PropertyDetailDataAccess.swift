//
//  PropertyDetailDataAccess.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

import Firebase
import FirebaseDatabase

class PropertyDetailDataAccess {
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var advertisment:[Advertisment]=[Advertisment]()
  //  let userID = "UserId"    
    
    func gatDataFromFirebase(completionForGetPropertyDetail : @escaping (_ propertyResult: [Advertisment]) -> Void){
        ref = Database.database().reference()
        ref.child("Advertisements").child("-M7ioq3ddJbzwwxcLmBP").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let price = value?["price"] as? String ?? ""
            let bed = value?["bedRooms"] as? String ?? ""
            let bath = value?["bathRooms"] as? String ?? ""
            let propertysize = value?["size"] as? String ?? ""
            let propertyType = value?["propertyType"] as? String ?? ""
            let country = value?["country"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            let dscription = value?["description"] as? String ?? ""
            let AdvertisementType = value?["Advertisement Type"] as? String ?? ""
            let userId=value?["userID"] as? String ?? ""
            let date = value?["date"] as? String ?? ""
            let address = value?["Address"] as? NSDictionary
            let lang = address?["longitude"]  as? String ?? ""
            let lat = address?["latitude"]  as? String ?? ""
            let loc = address?["location"]  as? String ?? ""
            let amenities = value?["amenities"] as? [String]
            let images = value?["images"] as? [String]

            let advertisments = Advertisment(userID: userId, advertismentType: AdvertisementType, propertyType: propertyType, bathroom: bath, bedroom: bed, country: country, date: date, description: dscription, phone: phone, price: price, size: propertysize, latitude: lat, longitude: lang, location: loc, amenities: amenities ?? ["amen default"], images: images ?? [""])
            
            self.advertisment.append(advertisments)

            completionForGetPropertyDetail(self.advertisment)
         
        })
    }
        
    }
    


