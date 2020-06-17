//
//  PropertyDetailDataAccessTests.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class PropertyDetailDataAccessTests: XCTestCase {

    var propertyDetailData: PropertyDetailDataAccess!
    var mocPropertyDetailData: MocPropertyDetailDataAccess!
    override func setUp() {
       propertyDetailData = PropertyDetailDataAccess()
       mocPropertyDetailData = MocPropertyDetailDataAccess()
    }

    func testGatAdvertisementDetialby(){
        let expectationObj = expectation(description: "Waiting for advertisement...")
        //  ad id = -MA16-T80n1xqodilijf   //   112233
        propertyDetailData.gatAdvertisementDetialby(id: "112233") { (advertisement,user) in
            expectationObj.fulfill()
            
            if (advertisement != nil){
                XCTAssertNotNil(advertisement,"advertisement has no value")
                XCTAssertNotNil(advertisement.advertismentType)
                XCTAssertNotNil(advertisement.amenities)
                XCTAssertNotNil(advertisement.bathroom)
                XCTAssertNotNil(advertisement.bedroom)
                XCTAssertNotNil(advertisement.location)
                XCTAssertNotNil(advertisement.longitude)
                XCTAssertNotNil(advertisement.latitude)
                XCTAssertNotNil(advertisement.date)
                XCTAssertNotNil(advertisement.country)
                XCTAssertNotNil(advertisement.description)
                XCTAssertNotNil(advertisement.images)
                XCTAssertNotNil(advertisement.userID)
                XCTAssertNotNil(advertisement.size)
                XCTAssertNotNil(advertisement.phone)
                XCTAssertNotNil(advertisement.price)
                XCTAssertNotNil(advertisement.propertyType)
            }else{
                XCTAssertNil(advertisement)
            }
            
            if (user != nil){
                XCTAssertNotNil(user,"advertisement has no value")
                XCTAssertNotNil(user.company)
                XCTAssertNotNil(user.name)
                XCTAssertNotNil(user.rate)
            }else{
                XCTAssertNil(user)
            }
        }
        waitForExpectations(timeout: 15)
    }
    
    func testGetUserDetails(){
        //8wnSEXCKodNSLQDZ3mAHCOt9RfD3
        propertyDetailData.getUserDetails(id: "8wnSEXCKodNSLQDZ3mAHCOt9RfD3") { (user) in
            if (user != nil){
                XCTAssertNotNil(user,"advertisement has no value")
                XCTAssertNotNil(user.company)
                XCTAssertNotNil(user.name)
                XCTAssertNotNil(user.rate)
            }else{
                XCTAssertNil(user)
            }
        }
    }
    
    override func tearDown() {
        propertyDetailData = nil
        mocPropertyDetailData=nil
    }

}
