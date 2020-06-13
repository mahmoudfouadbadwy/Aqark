//
//  FavouriteViewModelTests.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/10/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class FavouriteViewModelTests: XCTestCase {
    
    var favouriteViewModel:FavouriteListViewModel!
    
    override func setUp() {
        favouriteViewModel = FavouriteListViewModel(dataAccess: FavouriteDataAccess())
    }
    
    func testPopulateAds(){
        let expectationObj = expectation(description: "Waiting For response...")
        favouriteViewModel.populateAds(){(favResults,deletedCount) in
            expectationObj.fulfill()
            XCTAssertNotNil(favResults)
            XCTAssertNotNil(deletedCount)
            XCTAssertTrue(favResults.count <= self.favouriteViewModel.getAllAdvertisment().count)
        }
        waitForExpectations(timeout: 40)
    }
    
    func testGetAllAdvertisment(){
        
        XCTAssertNotNil(favouriteViewModel.getAllAdvertisment())
    }

    override func tearDown() {
        favouriteViewModel=nil
    }

}
