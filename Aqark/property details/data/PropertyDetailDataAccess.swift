//
//  PropertyDetailDataAccess.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.


import Foundation
import Firebase
import FirebaseDatabase

class PropertyDetailDataAccess {
    var ref: DatabaseReference!
    func gatAdvertisementDetialby(id :String ,completion: @escaping (_ propertyResult:Advertisment,Agent)-> Void){
        ref = Database.database().reference()
        ref.child("Advertisements").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists()
            {
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
                let userId=value?["UserId"] as? String ?? ""
                let date = value?["date"] as? String ?? ""
                let address = value?["Address"] as? NSDictionary
                let lang = address?["longitude"]  as? String ?? ""
                let lat = address?["latitude"]  as? String ?? ""
                let loc = address?["location"]  as? String ?? ""
                let amenities = value?["amenities"] as? [String]
                let images = value?["images"] as? [String]
                let advertisment = Advertisment(userID: userId, advertismentType: AdvertisementType, propertyType: propertyType, bathroom: bath, bedroom: bed, country: country, date: date, description: dscription, phone: phone, price: Double(price) ?? 0.0, size: propertysize, latitude: lat, longitude: lang, location: loc, amenities: amenities ?? [], images: images ?? [])
                self.getUserDetails(id: userId, completion: {(user) in
                    completion(advertisment, user)
                })
                
            }
        })
    }
    
    func getUserDetails(id:String,completion:@escaping(Agent)->Void)
    {
         ref = Database.database().reference()
        ref.child("Users").child(id).observeSingleEvent(of: .value) { (snapshot) in
            if (snapshot.exists())
            {
                let user = snapshot.value as! NSDictionary
                let name = user["username"] as? String ?? ""
                let company = user ["company"] as? String ?? ""
                let rate = user["rate"] as? Double ?? 0.0
                
                completion(Agent(name: name,company:company,rate:rate))
            }
        }
    }
    
}



