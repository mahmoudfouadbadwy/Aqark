//
//  PropertyDetailViewModelTests.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class PropertyDetailViewModelTests: XCTestCase {

    var propertyDetailViewModel: PropertyDetailViewModel!
    
    override func setUp() {
        propertyDetailViewModel = PropertyDetailViewModel(propertyDataAccess: PropertyDetailDataAccess())
    }
    
    func testCheckAdvertisementOwner(){
        XCTAssertFalse(propertyDetailViewModel.checkAdvertisementOwner(agentId: "4589598"))
        
    }
    
    func testPopulateAdvertisement(){
        let expectationObj = expectation(description: "Waiting for advertisement...")
        propertyDetailViewModel.populateAdvertisement(id: "-MA16-T80n1xqodilijf") { (advertisement,user) in
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
                XCTAssertNotNil(advertisement.propertysize)
                XCTAssertNotNil(advertisement.phone)
                XCTAssertNotNil(advertisement.price)
                XCTAssertNotNil(advertisement.propertyType)
            }else{
                XCTAssertNil(advertisement)
            }
            
            if (user != nil){
                XCTAssertNotNil(user,"advertisement has no value")
                XCTAssertNotNil(user.company)
                
            }else{
                XCTAssertNil(user)
            }
        }
        waitForExpectations(timeout: 15)
    }
    
    override func tearDown() {
        propertyDetailViewModel=nil
    }

}
