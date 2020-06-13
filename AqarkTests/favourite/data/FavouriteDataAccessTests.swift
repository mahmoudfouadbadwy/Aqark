//
//  FavouriteDataAccessTests.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/10/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class FavouriteDataAccessTests: XCTestCase {
    
    var favouriteDataAccess: FavouriteDataAccess!
    var mocfavouriteDataAccess:MocFavouriteDataAccess!
    
    override func setUp() {

        favouriteDataAccess = FavouriteDataAccess()
        mocfavouriteDataAccess=MocFavouriteDataAccess()
    }
   
    func testDeleteFavouriteAdsFromCoredata (){
        
        XCTAssertFalse(favouriteDataAccess.deleteFavouriteAdsFromCoredata(id: "123548562255"), "deleting succesfully")
        
    }
    
    func testGetFavouriteAdsFromCoredata(){

        let idsArray = CoreDataAccess.getAllAdvertisment(CoreDataAccess())
        XCTAssertNotNil(idsArray)
    }
    
    func testGetAllFavouriteAdvertisements(){
        let expectationObj = expectation(description: "Waiting For response...")
        favouriteDataAccess.getAllFavouriteAdvertisements { (adsData,deletedCount) in
            expectationObj.fulfill()
            XCTAssertTrue(deletedCount<adsData.count)
            XCTAssertNotNil(adsData)
            for advertisment in adsData{
                XCTAssertNotNil(advertisment.advertisementId)
                XCTAssertNotNil(advertisment.advertisementType)
                XCTAssertNotNil(advertisment.bathRoomsNumber)
                XCTAssertNotNil(advertisment.bedRoomsNumber)
                XCTAssertNotNil(advertisment.country)
                XCTAssertNotNil(advertisment.date)
                XCTAssertNotNil(advertisment.image)
                XCTAssertNotNil(advertisment.price)
                XCTAssertNotNil(advertisment.address)
                XCTAssertNotNil(advertisment.size)
                XCTAssertNotNil(advertisment.propertyType)
            }
        }
        waitForExpectations(timeout: 40)
    }
    
    override func tearDown() {
        favouriteDataAccess = nil
        mocfavouriteDataAccess = nil
    }


}
