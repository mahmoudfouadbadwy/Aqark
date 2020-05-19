//
//  ExtensionAddAdvertisementViewModel.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation


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
