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
    var coredataAds:CoreDataAccess!
    
    override func setUp() {
        favouriteViewModel = FavouriteListViewModel(dataAccess: FavouriteDataAccess())
        coredataAds=CoreDataAccess()
    }
    
    func testPopulateAds(){
        let expectationObj = expectation(description: "Waiting For response...")
        favouriteViewModel.populateAds(){(favResults,deletedCount) in
            expectationObj.fulfill()
            XCTAssertNotNil(favResults)
            XCTAssertNotNil(deletedCount)
            XCTAssertTrue(favResults.count <= self.coredataAds.getAllAdvertisment().count)
        }
        waitForExpectations(timeout: 40)
    }

    override func tearDown() {
        favouriteViewModel=nil
        coredataAds=nil
    }

}
