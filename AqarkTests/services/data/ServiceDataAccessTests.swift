//
//  ServiceDataAccessTests.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/15/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class ServiceDataAccessTests: XCTestCase {
    
    var serviceDataAccess : ServiceDataAccess!
    
    override func setUp() {
        serviceDataAccess = ServiceDataAccess()
    }
    
    override func tearDown(){
        serviceDataAccess = nil
    }
    
    func testGetServiceUsers(){
        let expectationObj = expectation(description: "Waiting For response...")
        serviceDataAccess.getServiceUsers { (serviceUsers) in
            expectationObj.fulfill()
            XCTAssertNotNil(serviceUsers)
            for serviceUser in serviceUsers{
                XCTAssertNotNil(serviceUser.userId)
                XCTAssertNotNil(serviceUser.userName)
                XCTAssertNotNil(serviceUser.userCountry)
                XCTAssertNotNil(serviceUser.userCompany)
                XCTAssertNotNil(serviceUser.userEmail)
                XCTAssertNotNil(serviceUser.userRole)
                XCTAssertNotNil(serviceUser.userServiceRating)
                XCTAssertNotNil(serviceUser.userExperience)
                XCTAssertNotNil(serviceUser.userPhone)
                XCTAssertNotNil(serviceUser.userImage)
            }
        }
        waitForExpectations(timeout: 15)
    }
    
    func testGetUserServiceRating(){
         let userRatingsDictionary = ["ID1":5.0,
                                      "ID2":5.0,
                                      "ID3":5.0]
         let biggestRating = userRatingsDictionary.max{(a,b) -> Bool in
             a.value > b.value
             }!.value
         let lowestRating = userRatingsDictionary.min { (a, b) -> Bool in
             a.value < b.value
             }!.value
         var totalRating = 0.0
         
         for rating in userRatingsDictionary{
             totalRating += rating.value
         }
         let rating = totalRating/Double(userRatingsDictionary.count)
         
         let emptyUserRatingDictionart : [String:Any] = [:]
         let userRating = serviceDataAccess.getUserServiceRating(userRatingDic:userRatingsDictionary)
         let zeroUserRating = serviceDataAccess.getUserServiceRating(userRatingDic: emptyUserRatingDictionart)
         XCTAssertEqual(userRating,rating)
         XCTAssertFalse(userRating > biggestRating)
         XCTAssertFalse(userRating < lowestRating)
         XCTAssertTrue(userRating < totalRating)
         XCTAssertEqual(zeroUserRating,0.0)
     }
}
