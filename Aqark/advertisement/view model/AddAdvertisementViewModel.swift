//
//  AddAdvertisementViewModel.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import ReachabilitySwift
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
    var dataImages :[Data]?
    var urlImages :[String]?
    var deletedImage :[String]?
    var payment : String!
    var date :String!
    
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
    
    init(editDataSource : EditAdvertisementDataSource) {
        editAdvertisementDataSource = editDataSource
    }
    
    
    init(payment : String , propertyType: String , advertisementType:String?, price: String , bedrooms: String , bathroom: String? , size: String , phone: String , location: String , latitude: String , longitude: String , country: String? , description: String , aminities : [Int:String] ,dataImages :[Data] , urlImages:[String] , deletedImage : [String]) {
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
        self.deletedImage = deletedImage
    }
    
    func save(){
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
                                                          aminities: Array(aminities.values) ,
                                                          date: getCurrentDate(),
                                                          images: dataImages!,
                                                          payment: payment)
        addAdvertisementDataSource = AddAdvertisementDataSource()
        addAdvertisementDataSource.initializeAddAdvertisementDataSource(advertisement: addAdvertisementModel)
    }
    
    private func getCurrentDate()->String
    {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: now)
    }
    
    func removeAllAddDataRefrance(){
        addAdvertisementDataSource.removeAllAddDataRefrance()
    }
    
    func removeAllEditDataRefrance(){
        editAdvertisementDataSource.removeAllEditDataRefrance()
    }
    
    
}


struct AdvertisementNetworking
{
    
    static func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}
