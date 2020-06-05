//
//  Helper.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct  AdminUserKey {
    static let userName = "username"
    static let userEmail = "email"
    static let userPhone = "phone"
    static let userCompany = "company"
    static let userCountry = "country"
    static let userRole = "role"
    static let userExperience = "experience"
    static let userRating = "rate"
    static let userPicture = "picture"

    static let banned = "banned"

}

struct AdminUserRole {
    static let user = "user"
    static let lawyer = "lawyer"
    static let interiorDesigner = "interior designer"
}

struct AdminAdvertisementKey {
    static let address = "Address"
    static let longitude = "longitude"
    static let latitude = "latitude"
    static let location = "location"
    static let advertisementType = "Advertisement Type"
    static let userId = "UserId"
    static let amenities = "amenities"
    static let bathRooms = "bathRooms"
    static let bedRooms = "bedRooms"
    static let country = "country"
    static let date = "date"
    static let description = "description"
    static let images = "images"
    static let payment = "payment"
    static let phone = "phone"
    static let price = "price"
    static let propertyType = "propertyType"
    static let size = "size"
}

struct AdvertisementType{
    static let rent = "Rent"
    static let buy = "Buy"
}
