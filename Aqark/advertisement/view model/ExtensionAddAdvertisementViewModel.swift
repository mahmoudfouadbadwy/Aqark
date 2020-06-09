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
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "propertyType".localize, message: "select Property Type".localize))
        }
        if(advertisementType.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "advertisementType".localize, message: "select advertisement Type".localize))
        }
        if((price.isEmpty) || (price.isEmpty == false)){
            PriceTextFeildError()
        }
        if(bedrooms.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "bedrooms".localize, message: "add number of bedrooms".localize))
        }
        if(bathroom.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "bathroom".localize, message: "select number of bathroom".localize))
        }
        if((size.isEmpty) || (size.isEmpty == false)){
             sizeValidate(value: size)
        }
        if((phone.isEmpty) || (phone.isEmpty == false)){
            phoneValidate(value: phone)
        }
        if(location.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "location".localize, message: "add your location".localize))
        }
        if(country.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "country".localize, message: "add your county".localize))
        }
        if(description.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "description".localize, message: "add your description".localize))
        }
        if(dataImages!.count + urlImages!.count == 0){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "images".localize, message: "select images".localize))
        }
    }
    
    func phoneValidate(value: String){
           
        let PHONE_REGEX = "^[0][1]\\d{9}$".localize
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        if (value.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "Mobile Number".localize, message: "add your phone".localize))
        }else{
            if !(phoneTest.evaluate(with: value)) {
                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "Mobile Number".localize, message: "phone not valid".localize))
            }
        }
    }
          
    func sizeValidate(value: String){
           
        let SIZE_REGEX = "^[1-9][0-9]*$".localize
        let sizeTest = NSPredicate(format: "SELF MATCHES %@", SIZE_REGEX)
        
        if (value.isEmpty){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "Size".localize, message: "add your size".localize))
        }else{
            if !(sizeTest.evaluate(with: value)) {
                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "Size".localize, message: "inValid size".localize))
            }
        }
    }
    
    
    func PriceTextFeildError(){

        var myMessage = ""
        let PRICE_REGEX = "^[1-9][0-9]*$".localize
        let priceTest = NSPredicate(format: "SELF MATCHES %@", PRICE_REGEX)
        if (price.isEmpty){
            myMessage = "price is empty".localize
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: myMessage ))
        }else{
            
            if priceTest.evaluate(with: price) {
                
                let myPrice = Localization.convertNumbers(lang: "lang".localize, stringNumber: price).0.intValue
                
                if advertisementType == "Rent".localize{
                     switch propertyType {
                         case "Apartment" where  myPrice < 500:
                            myMessage = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "500").1  + "EGP".localize
                            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: myMessage ))
                         case "Villa" where  myPrice < 5000:
                             myMessage = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "5000").1  + "EGP".localize
                             
                             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: myMessage ))
                         case "Room" where  myPrice < 200:
                             myMessage = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "200").1  + "EGP".localize
                             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: myMessage ))
                         default:
                             print("NoError")
                        }
                }else{
                    
                    switch propertyType {
                        case "Apartment" where  myPrice < 50000:
                            myMessage = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "50000").1  + "EGP".localize
                            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: myMessage ))
                        case "Villa" where  myPrice < 500000:
                            myMessage = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "500000").1  + "EGP".localize
                            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: myMessage ))
                        case "Room" where  myPrice < 10000:
                             myMessage = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "10000").1  + "EGP".localize
                             self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: myMessage ))
                        default:
                            print("NoError")
                    }
                }
                
            }else{
                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price".localize, message: "inValid price".localize))
            }
        }
    }
    
    
}
