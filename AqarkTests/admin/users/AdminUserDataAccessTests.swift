//
//  AdminDataAccessTests.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class AdminDataAccessTests : XCTestCase {
    
    var adminDataAccess : AdminDataAccess!
    var adminUserDataAccess : MockAdminUserDataAccess!
    var adminAdvertisementDataAcess : MockAdminAdvertisementDataAccess!
    
    override func setUpWithError() throws {
        adminDataAccess = AdminDataAccess()
        adminUserDataAccess  = MockAdminUserDataAccess(shouldReturnError: false)
        adminAdvertisementDataAcess = MockAdminAdvertisementDataAccess()
    }
    
    func testGetUsers(){
        let expectationObj = expectation(description: "Waiting For response...")
        adminDataAccess.getUsers { (usersData) in
            expectationObj.fulfill()
            XCTAssertNotNil(usersData)
            for user in usersData{
                XCTAssertNotNil(user.userId)
                XCTAssertNotNil(user.userName)
                XCTAssertNotNil(user.userCountry)
                XCTAssertNotNil(user.userCompany)
                XCTAssertNotNil(user.userEmail)
                XCTAssertNotNil(user.userRole)
                XCTAssertNotNil(user.userExperience)
                XCTAssertNotNil(user.userPhone)
                XCTAssertNotNil(user.userImage)
                XCTAssertNotNil(user.isBanned)
            }
        }
        waitForExpectations(timeout: 15)
    }
    
    func testGetUserRating(){
        let userRatingsDictionary = ["ID1":5.0,
                                     "ID2":5.0,
                                     "ID3":5.0]
        var biggestRating = 0.0
        let lowestRating = userRatingsDictionary.min { (a, b) -> Bool in
            a.value < b.value
            }!.value
        
        for rating in userRatingsDictionary{
            biggestRating += rating.value
        }
        
        let rating = biggestRating/Double(userRatingsDictionary.count)
        
        let emptyUserRatingDictionart : [String:Any] = [:]
        let userRating = adminDataAccess.getUserRating(userRatingDic:userRatingsDictionary)
        let zeroUserRating = adminDataAccess.getUserRating(userRatingDic: emptyUserRatingDictionart)
        XCTAssertEqual(userRating,rating)
        XCTAssertTrue(userRating < biggestRating)
        XCTAssertFalse(userRating < lowestRating)
        XCTAssertEqual(zeroUserRating,0.0)
    }
    
    func testLogout(){
        let expectationObj = expectation(description: "Waiting to logout...")
        adminDataAccess.logout(){ (signOutError) in
            expectationObj.fulfill()
            if signOutError != nil{
                XCTFail("There is error with logout")
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    
    override func tearDownWithError() throws {
        adminDataAccess = nil
    }
    
}
