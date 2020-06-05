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
        if(dataImages!.count + urlImages!.count == 0){
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "images", message: "select images"))
        }
    }
    
    func phoneValidate(value: String){
           
        let PHONE_REGEX = "^[0][1]\\d{9}$".localize
        
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
           
        let SIZE_REGEX = "^[1-9][0-9]*$".localize
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
        let PRICE_REGEX = "^[1-9][0-9]*$".localize
        let priceTest = NSPredicate(format: "SELF MATCHES %@", PRICE_REGEX)
        if (price.isEmpty){
            myMessage = "price is empty"
            self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
        }else{
            
            if priceTest.evaluate(with: price) {
                
                if let myPrice = price{
                    
                    if advertisementType == "Rent".localize{
                         switch propertyType {
                         case "Apartment".localize where  self.convertNumbers(lang: "lang".localize, stringNumber: myPrice).0.intValue < self.convertNumbers(lang: "lang".localize, stringNumber: "500").0.intValue:
                                myMessage = "minimum price is".localize + self.convertNumbers(lang: "lang".localize, stringNumber: "500").1 + "EGP".localize
                                 self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                         case "Villa".localize where  self.convertNumbers(lang: "lang".localize, stringNumber: myPrice).0.intValue < self.convertNumbers(lang: "lang".localize, stringNumber: "5000").0.intValue:
                                myMessage = "minimum price is".localize + self.convertNumbers(lang: "lang".localize, stringNumber: "5000").1 + "EGP".localize
                                 self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                         case "Room".localize where  self.convertNumbers(lang: "lang".localize, stringNumber: myPrice).0.intValue < self.convertNumbers(lang: "lang".localize, stringNumber: "200").0.intValue:
                                myMessage = "minimum price is".localize + self.convertNumbers(lang: "lang".localize, stringNumber: "200").1 + "EGP".localize
                                 self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                             default:
                                 print("NoError")
                            }
                    }else{
                        
                        switch propertyType {
                        case "Apartment".localize where  self.convertNumbers(lang: "lang".localize, stringNumber: myPrice).0.intValue < self.convertNumbers(lang: "lang".localize, stringNumber: "50000").0.intValue:
                                myMessage = "minimum price is".localize + self.convertNumbers(lang: "lang".localize, stringNumber: "50000").1 + "EGP".localize
                                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                        case "Villa".localize where  self.convertNumbers(lang: "lang".localize, stringNumber: myPrice).0.intValue < self.convertNumbers(lang: "lang".localize, stringNumber: "500000").0.intValue:
                                myMessage = "minimum price is".localize + self.convertNumbers(lang: "lang".localize, stringNumber: "500000").1 + "EGP".localize
                                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                        case "Room".localize where  self.convertNumbers(lang: "lang".localize, stringNumber: myPrice).0.intValue < self.convertNumbers(lang: "lang".localize, stringNumber: "10000").0.intValue:
                                myMessage = "minimum price is".localize + self.convertNumbers(lang: "lang".localize, stringNumber: "10000").1 + "EGP".localize
                                 self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: myMessage ))
                            default:
                                print("NoError")
                        }
                    }
                    
                }
                 
                
            }else{
                self.borkenRule.append(AddAdvertisementBrokenRule(brokenType: "price", message: " inValid price"))
            }
        }
    }
    
    
}

extension AddAdvertisementViewModel{

    func convertNumbers(lang: String , stringNumber : String)->(NSNumber, String){
        let formatter: NumberFormatter = NumberFormatter()
        if lang.elementsEqual("en"){
            formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        }else{
            formatter.locale = NSLocale(localeIdentifier: "AR") as Locale?
        }
        guard let number = formatter.number(from: stringNumber)else{return(0 , "")}
        guard let translatedNumber = formatter.string(from: number)else{return(0,"")}
        
        return(number , translatedNumber)
    }

}
