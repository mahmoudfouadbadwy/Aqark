//
//  AdminAdvertisementViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class AdminAdvertisementViewModel{
    var advertisementId : String = ""
    var advertisementUserId : String = ""
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
        self.advertisementPropertyImages = adminAdvertisment.advertismentsPropertyImages
        self.advertisementPropertyType = adminAdvertisment.advertisementPropertyType
        self.advertisementPropertyAddress = adminAdvertisment.advertisementPropertyLocation
        self.advertisementPropertyPrice = adminAdvertisment.advertisementPropertyPrice
        self.advertisementPropertySize = adminAdvertisment.advertisementPropertySize
        self.advertisementPropertyBedsNumber = adminAdvertisment.advertisementPropertyBeds
        self.advertisementPropertyBathRoomsNumber = adminAdvertisment.advertisementPropertyBathRooms
    }
}
