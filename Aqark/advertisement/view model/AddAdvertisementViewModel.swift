//
//  AddAdvertisementViewModel.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

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
    var dataImages :[Data]
    var urlImages :[String]
    var payment : String!
    
    var editAdvertisementDataSource: EditAdvertisementDataSource!
    var addAdvertisementDataSource: AddAdvertisementDataSource!
    var borkenRule: [AddAdvertisementBrokenRule] = [AddAdvertisementBrokenRule]()
    
    var isValid: Bool{
        get{
            self.borkenRule = [AddAdvertisementBrokenRule]()
            self.MakeValidation()
            return self.borkenRule.count == 0 ? true : false
        }
    }
  
    
    init(payment : String , propertyType: String , advertisementType:String?, price: String , bedrooms: String , bathroom: String? , size: String , phone: String , location: String , latitude: String , longitude: String , country: String? , description: String , aminities : [Int:String] ,dataImages :[Data] , urlImages:[String]) {
        
        self.payment = payment
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
        self.dataImages = dataImages
        self.urlImages = urlImages
    }
    
    
    
    
    func save(){
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        let amins = Array(aminities.values)
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
                                                          aminities: amins ,
                                                          date: dateString,
                                                          images: dataImages,
                                                          payment: payment)
        
        
        addAdvertisementDataSource = AddAdvertisementDataSource()
        addAdvertisementDataSource.initializeAddAdvertisementDataSource(advertisement: addAdvertisementModel)
        
    }
    
    
}
