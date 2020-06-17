//
//  SearchTest.swift
//  AqarkTests
//
//  Created by Shorouk Mohamed on 6/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class SearchTest: XCTestCase {
//    var searchData : AdvertisementData!
    var searchData : MockSearchData!

    override func setUpWithError() throws {
//       searchData = AdvertisementData()
        searchData = MockSearchData()
        
    }

    func testGetAllAdvertisements(){
        let expectationObj = expectation(description: "Get Data")
        searchData.getAdvertisements { (advertisements) in
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
            expectationObj.fulfill()
            XCTAssertEqual(advertisements.count, 20)
           
        }
        waitForExpectations(timeout: 30)
        
    }
    
    override func tearDownWithError() throws {
        searchData = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
