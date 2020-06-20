//
//  AdvertisementListViewModelTests.swift
//  AqarkTests
//
//  Created by Shorouk Mohamed on 6/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class AdvertisementListViewModelTests: XCTestCase {

    var data : AdvertisementData!
    var adViewModel : AdvertisementListViewModel!
    override func setUp(){
        data = AdvertisementData()
        adViewModel = AdvertisementListViewModel(dataAccess: data)
    }
    
    func testPopulateAds(){
    let expectationObj = expectation(description: "Get Data")
        adViewModel.populateAds(){(advertisements) in
             expectationObj.fulfill()

                XCTAssertEqual(advertisements.count, 3)
            XCTAssertEqual(self.adViewModel.advertismentsViewModel.count, advertisements.count)
            }
            waitForExpectations(timeout: 30)
            
        
    }

    override func tearDown(){
        data = nil
        adViewModel = nil
    }


}
