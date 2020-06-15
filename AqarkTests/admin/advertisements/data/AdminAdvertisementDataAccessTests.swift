//
//  AdminAdvertisementDataAccessTests.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

extension AdminDataAccessTests{
    
    func testGetAdvertisements(){
        let expectationObj = expectation(description: "Waiting for advertisement...")
        adminDataAccess.getAdvertisements { (advertisements) in
            expectationObj.fulfill()
            for advertisement in advertisements{
                XCTAssertNotNil(advertisement.advertisementId)
                XCTAssertNotNil(advertisement.advertisementPropertyLatitude)
                XCTAssertNotNil(advertisement.advertisementPropertyLongitude)
                XCTAssertNotNil(advertisement.advertisementPropertyLocation)
                XCTAssertNotNil(advertisement.advertisementPropertyType)
                XCTAssertNotNil(advertisement.advertisemetentUserId)
                XCTAssertNotNil(advertisement.advertisementPropertyAmenities)
                XCTAssertNotNil(advertisement.advertisementPropertyBathRooms)
                XCTAssertNotNil(advertisement.advertisementPropertyBeds)
                XCTAssertNotNil(advertisement.advertisementCountry)
                XCTAssertNotNil(advertisement.advertisementDate)
                XCTAssertNotNil(advertisement.advertisementPropertyDescription)
                XCTAssertNotNil(advertisement.advertismentsPropertyImages)
                XCTAssertNotNil(advertisement.advertisementPaymentType)
                XCTAssertNotNil(advertisement.adevertisementPhone)
                XCTAssertNotNil(advertisement.advertisementPropertyPrice)
                XCTAssertNotNil(advertisement.advertisementPropertyType)
                XCTAssertNotNil(advertisement.advertisementPropertySize)
            }
        }
        waitForExpectations(timeout: 15)
    }
    
    func testDeleteAdvertisment(){
        let advertisement = AdminAdvertisement(advertisementId: "112233", advertisementPropertyLatitude: "31.76", advertisementPropertyLongitude: "33.11", advertisementPropertyLocation: "Mansoura", advertisementType: "Rent", advertisemetentUserId: "123", advertisementPropertyAmenities: [""], advertisementPropertyBathRooms: "1", advertisementPropertyBeds: "1", advertisementCountry: "Mansoura", advertisementDate: "2020", advertisementPropertyDescription: "Nice", advertismentsPropertyImages: [""], advertisementPaymentType: "Free", adevertisementPhone: "111", advertisementPropertyPrice: "150", advertisementPropertyType: "Room", advertisementPropertySize: "100")
        let advertisementModel = AdminAdvertisementViewModel(adminAdvertisment: advertisement)
        adminDataAccess.deleteAdvertisment(adminAdvertisement: advertisementModel) { (deleted) in
            if(deleted){
                //Case Mocking Object
                //XCTAssertEqual(self.adminAdvertisementDataAcess.advertisementsArray.count, 1)
                XCTFail()
            }else{
                //Case real data access
                XCTAssertTrue(deleted == false)
            }
        }
    }
}

