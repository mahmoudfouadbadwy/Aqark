//
//  MocPropertyDetailDataAccess.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
@testable import Aqark

class MocPropertyDetailDataAccess{
 
    let advertisement : [String : Any] = ["112233":
        ["Address":["latitude":"31.76","longitude":"33.11","location":"Mansoura"],
         "Advertisement Type":"Rent",
         "UserId":"123",
         "amenities":["study"],
         "bathRooms":"1",
         "bedRooms":"1",
         "country":"giza",
         "date":"2020",
         "description":"Nice",
         "images":[""],
         "payment":"free",
         "phone":"111",
         "price":"150",
         "propertyType":"Room",
         "size":"100"]]
    let agent=["334455":
        ["country":"Giza",
         "company":"iti",
         "email":"z@gmail.com",
         "experience":"1",
         "phone":"010215684",
         "role":"user",
         "picture":" ",
         "username":"zeynab",
         "rate":["":0.0] ]]
    
    func gatAdvertisementDetialby(id : String ,completion: @escaping (_ propertyResult:Advertisment,Agent)-> Void){
        if id=="112233"{
            let images = advertisement["images"] as? [String]
            let amenities = advertisement["amenities"] as? [String]
            let advertisementPropertyType = advertisement["propertyType"] as? String ?? "Not Applied"
            let advertisementType = advertisement["Advertisement Type"] as? String ?? "Not Applied"
            let advertisementCountry = advertisement["country"] as? String ?? "Not Applied"
            let advertisementPropertySize = advertisement["size"] as? String ?? "Not Applied"
            let advertisementDate = advertisement["date"] as? String ?? "Not Applied"
            let userId = advertisement["UserId"] as? String ?? "Not Applied"
            let advertisementBedRoomsNum = advertisement["bedRooms"] as? String ?? "Not Applied"
            let advertisementBathRoomsNum = advertisement["bathRooms"] as? String ?? "Not Applied"
            let advertisementphone = advertisement["phone"] as? String ?? "Not Applied"
            let advertisementDescription = advertisement["description"] as? String ?? "Not Applied"
            let advertisementPropertyPrice = Localization.convertNumbers(lang: "lang".localize, stringNumber: (advertisement["price"] as? String) ?? "0").0.stringValue
            let advertisementPropertyLocation:String!
            var longitude="" , latitude=""
            if var unwrappedAddressDict = advertisement["Address"] {
                unwrappedAddressDict = advertisement["Address"] as! [String : String]
                let addressDictionary = unwrappedAddressDict as! [String : String]
                advertisementPropertyLocation = addressDictionary["location"] ?? "Not Applied"
                latitude = addressDictionary["latitude"] ?? "0.0"
                longitude = addressDictionary["longitude"] ?? "0.0"
            }else{
                advertisementPropertyLocation = "Not Applied"
            }
            let ad=Advertisment(userID: userId, advertismentType: advertisementType, propertyType: advertisementPropertyType, bathroom: advertisementBathRoomsNum, bedroom: advertisementBedRoomsNum, country: advertisementCountry, date: advertisementDate, description: advertisementDescription, phone: advertisementphone, price: Double(advertisementPropertyPrice), size: advertisementPropertySize, latitude: latitude, longitude: longitude, location: advertisementPropertyLocation, amenities: amenities, images: images
                
            )
            self.getUserDetails(id: userId, completion: {(user) in
                completion(ad, user)
            })
            
        }else{
            print("invalid ad id")
        }
        
    }
    
    
    func getUserDetails(id:String,completion:@escaping(Agent)->Void)
    {
        if (id != nil)
        {
            let name = agent["username"] as! String ?? ""
            let company = agent ["company"] as! String ?? ""
            let rate = agent["rate"] as! [String:Double] ?? ["":0.0]
            completion(Agent(name: name,company:company,rate:rate))
        }else{
            print("user id didn't exist")
        }
    }
}
