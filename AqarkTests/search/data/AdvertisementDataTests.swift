//
//  SearchTest.swift
//  AqarkTests
//
//  Created by Shorouk Mohamed on 6/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark


class AdvertisementDataTests: XCTestCase {
    var searchData : AdvertisementData!
//    var searchData : MockSearchData!

    override func setUp(){
       searchData = AdvertisementData()
//        searchData = MockSearchData()
        
    }

    func testGetAllAdvertisements(){
        let expectationObj = expectation(description: "Get Data")
        searchData.getAllAdvertisements{ (advertisements) in
             expectationObj.fulfill()
            for ad in advertisements {
                XCTAssertNotNil(ad.address)
                XCTAssertNotNil(ad.price)
                XCTAssertNotNil(ad.advertisementId)
                XCTAssertNotNil(ad.advertisementType)
                XCTAssertNotNil(ad.bathRoomsNumber)
                XCTAssertNotNil(ad.bedRoomsNumber)
                XCTAssertNotNil(ad.country)
                XCTAssertNotNil(ad.date)
                XCTAssertNotNil(ad.image)
                XCTAssertNotNil(ad.latitude)
                XCTAssertNotNil(ad.longtiude)
                       }
            XCTAssertEqual(advertisements.count, 3)
           
        }
        waitForExpectations(timeout: 30)
        
    }
    
    override func tearDown(){
        searchData = nil
    }


}
