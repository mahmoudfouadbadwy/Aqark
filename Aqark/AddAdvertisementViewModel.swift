//
//  AddAdvertisementViewModel.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct AddAdvertisementBrokenRule{
    
    var brokenType : String
    var message : String
    
}
protocol AddAdvertisementViewModelProtocol {
    var borkenRule : [AddAdvertisementBrokenRule] {get set}
    var isValid : Bool{get}
}



class AddAdvertisementViewModel : AddAdvertisementViewModelProtocol{
    
    
    var propertyType: String!
    var advertisementType:String!
    var price: String!
    var bedrooms: String!
    var bathroom: String!
    var size: String!
    var phone: String!
    var location: String!
    var latitude: String!
    var longitude: String!
    var country: String!
    var description: String!
    var aminities : [Int:String]!
    var images :[Data]!
    
    
    
    
    var addAdvertisementDataSource: AddAdvertisementDataSource!
    
    var borkenRule: [AddAdvertisementBrokenRule] = [AddAdvertisementBrokenRule]()
    
       
       var isValid: Bool{
           get{
               self.borkenRule = [AddAdvertisementBrokenRule]()
               self.MakeValidation()
               return self.borkenRule.count == 0 ? true : false
           }
       }
    
    
    init(propertyType: String , advertisementType:String?, price: String , bedrooms: String , bathroom: String? , size: String , phone: String , location: String , latitude: String , longitude: String , country: String? , description: String , aminities : [Int:String] , images :[Data]) {
        
        self.propertyType = propertyType
        self.advertisementType = advertisementType
        self.price = price
        self.bedrooms = bedrooms
        self.bathroom = bathroom
        self.size = size
        self.phone = phone
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.country = country
        self.description = description
        self.aminities = aminities
        self.images = images
    }
    
    
    
    
    func save(){
        
          let now = Date()
          let formatter = DateFormatter()
          formatter.timeZone = TimeZone.current
          formatter.dateFormat = "yyyy-MM-dd HH:mm"
          let dateString = formatter.string(from: now)
            print(dateString)
        
        let amin = Array(aminities.values)
        
        
        let addAdvertisementModel = AddAdvertisementModel(propertyType: propertyType,
                                                          advertisementType: advertisementType,
                                                          price: price,
                                                          bedrooms: bedrooms,
                                                          bathroom: bathroom,
                                                          size: size,
                                                          phone: phone,
                                                          location: location,
                                                          latitude: latitude,
                                                          longitude: longitude,
                                                          country: country,
                                                          description: description,
                                                          aminities: amin ,
                                                          date: dateString,
                                                          images: images)
        
        
        addAdvertisementDataSource = AddAdvertisementDataSource(advertisement: addAdvertisementModel)
        
        addAdvertisementDataSource.addAdvertisementInFirebase()
        
    }
    
    
}

extension AddAdvertisementViewModel{
    
    func MakeValidation(){
        
        if(propertyType.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "prooertyType", message: "select Property Type"))
        }
        if(advertisementType.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "advertisementType", message: "select advertisement Type"))
        }
        if((price.isEmpty) || (price.isEmpty == false)){
            PriceTextFeildError()
        }
        if(bedrooms.isEmpty){
             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "bedrooms", message: "add number of bedrooms"))
        }
        if(bathroom.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "bathroom", message: "select number of bathroom"))
        }
        if((size.isEmpty) || (size.isEmpty == false)){
             sizeValidate(value: size)
        }
        if((phone.isEmpty) || (phone.isEmpty == false)){
            
            phoneValidate(value: phone)
             
        }
        if(location.isEmpty){
             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "location", message: "add your location"))
        }
        if(country.isEmpty){
             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "country", message: "add your county"))
        }
        if(description.isEmpty){
             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "description", message: "add your description"))
        }
        if(images.count == 0){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "images", message: "select images"))
        }
        
    
    }
    
    func phoneValidate(value: String){
           
        let PHONE_REGEX = "^[0][1]\\d{9}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        if (value.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "phone", message: "add your phone"))
        }else{
            if phoneTest.evaluate(with: value) {
                
            }else{
                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "phone", message: "phone not valid"))
            }
        }
    }
          
    func sizeValidate(value: String){
           
        let SIZE_REGEX = "^[1-9][0-9]*$"
        let sizeTest = NSPredicate(format: "SELF MATCHES %@", SIZE_REGEX)
        
        if (value.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "Size", message: "add your size"))
        }else{
            if sizeTest.evaluate(with: value) {
                
            }else{
                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "Size", message: " inValid size"))
            }
        }
    }
    
    
    func PriceTextFeildError(){

        var myMessage = ""
        
        
        let PRICE_REGEX = "^[1-9][0-9]*$"
        let priceTest = NSPredicate(format: "SELF MATCHES %@", PRICE_REGEX)
        if (price.isEmpty){
            myMessage = "price is empty"
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
        }else{
            
            if priceTest.evaluate(with: price) {
                
                let myPrice = Int(price)
                 
                 if advertisementType == "Rent"{
                     switch propertyType {
                         case "Apartment" where  myPrice! < 500:
                             myMessage = "minimum price is 500$ "
                             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                         case "Villa" where  myPrice! < 5000:
                             myMessage = "minimum price is 5000$ "
                             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                         case "Room" where  myPrice! < 200:
                             myMessage = "minimum price is 200$ "
                             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                         
                         default:
                             print("NoError")
                        }
                }else{
                    
                    switch propertyType {
                        case "Apartment" where  myPrice! < 50000:
                            myMessage = "minimum price is 50,000$ "
                            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                        case "Villa" where  myPrice! < 500000:
                            myMessage = "minimum price is 500,000$ "
                            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                        case "Room" where  myPrice! < 10000:
                             myMessage = "minimum price is 10,000$ "
                             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                        default:
                            print("NoError")
                    }
                }
                
            }else{
                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: " inValid price"))
            }
        }
        
       
    
    
}
}
