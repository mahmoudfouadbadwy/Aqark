//
//  AdminAdvertisementViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct AdminAdvertisementViewModel{
    var advertisementId : String = ""
    var advertisementUserId : String = ""
    var advertisementType : String = ""
    var advertisementPaymentType : String = ""
    var advertisementPropertyImages : [String] = [String]()
    var advertisementPropertyType : String = ""
    var advertisementPropertyAddress : String = ""
    var advertisementPropertyPrice : String = ""
    var advertisementPropertySize : String = ""
    var advertisementPropertyBedsNumber : String = ""
    var advertisementPropertyBathRoomsNumber : String = ""
    
    init(adminAdvertisment:AdminAdvertisement) {
        self.advertisementId = adminAdvertisment.advertisementId
        self.advertisementUserId = adminAdvertisment.advertisemetentUserId
        self.advertisementType = adminAdvertisment.advertisementType
        self.advertisementPaymentType = adminAdvertisment.advertisementPaymentType
        self.advertisementPropertyImages = adminAdvertisment.advertismentsPropertyImages
        self.advertisementPropertyType = adminAdvertisment.advertisementPropertyType
        self.advertisementPropertyAddress = adminAdvertisment.advertisementPropertyLocation
        self.advertisementPropertyPrice = adminAdvertisment.advertisementPropertyPrice + checkPropertyType(advertisementType: advertisementType)
        self.advertisementPropertySize = adminAdvertisment.advertisementPropertySize + " sqm"
        self.advertisementPropertyBedsNumber = adminAdvertisment.advertisementPropertyBeds
        self.advertisementPropertyBathRoomsNumber = adminAdvertisment.advertisementPropertyBathRooms
    }
    
    private func checkPropertyType(advertisementType:String)->String{
        switch advertisementType {
        case AdvertisementType.rent:
            return " EGP/month"
        case AdvertisementType.buy:
            return " EGP"
        default:
            return ""
        }
    }
}
