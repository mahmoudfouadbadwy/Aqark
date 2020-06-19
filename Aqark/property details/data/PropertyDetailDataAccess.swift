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

    var advertismentsRef: DatabaseReference! = Database.database().reference()
    var userRef: DatabaseReference! = Database.database().reference()
    var userHandle:DatabaseHandle!
    var advertismentId:String=""
    var userId:String=""
   
    func gatAdvertisementDetialby(id :String ,completion: @escaping (_ propertyResult:Advertisment,Agent)-> Void){
        advertismentId=id
        advertismentsRef.child("Advertisements").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists()
            {
                let value = snapshot.value as? NSDictionary
                let price = Localization.convertNumbers(lang: "lang".localize, stringNumber: (value?["price"] as? String) ?? "0").0.stringValue 
                let bed = value?["bedRooms"] as? String ?? ""
                let bath = value?["bathRooms"] as? String ?? ""
                let propertysize = value?["size"] as? String ?? ""
                let propertyType = value?["propertyType"] as? String ?? ""
                let country = value?["country"] as? String ?? ""
                let phone = value?["phone"] as? String ?? ""
                let dscription = value?["description"] as? String ?? ""
                let AdvertisementType = value?["Advertisement Type"] as? String ?? ""
                let userId=value?["UserId"] as? String ?? ""
                self.userId=userId
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
     userHandle = userRef.child("Users").child(id).observe(.value, with: { (snapshot) in
            if (snapshot.exists())
            {
                let user = snapshot.value as! NSDictionary
                let name = user["username"] as? String ?? ""
                let company = user ["company"] as? String ?? ""
                let rate = user["rate"] as? [String:Double] ?? ["":0.0]
                completion(Agent(name: name,company:company,rate:rate))
            }
        })
    }
    func reomvepropertyDetailObserver()
    {
        userRef.child("Users").removeObserver(withHandle: userHandle)
        userHandle = nil
        userRef = nil
        advertismentsRef = nil
    }
}



