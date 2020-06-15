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
            XCTAssertNil(serviceUsers)
            for serviceUser in serviceUsers{
                XCTAssertNotNil(serviceUser.userId)
                XCTAssertNotNil(serviceUser.userName)
                XCTAssertNotNil(serviceUser.userCountry)
                XCTAssertNotNil(serviceUser.userCompany)
                XCTAssertNotNil(serviceUser.userEmail)
                XCTAssertNotNil(serviceUser.userRole)
                XCTAssertNotNil(serviceUser.userExperience)
                XCTAssertNotNil(serviceUser.userPhone)
                XCTAssertNotNil(serviceUser.userImage)
            }
        }
        waitForExpectations(timeout: 15)
    }
}
