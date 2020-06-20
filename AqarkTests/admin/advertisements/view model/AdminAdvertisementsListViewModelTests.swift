//
//  AdminAdvertisementsListViewModelTests.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/7/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class AdminAdvertisementsListViewModelTests: XCTestCase {
    
    var dataAccess : AdminDataAccess!
    var adminAdvertisementsViewModel : AdminAdvertisementsListViewModel!
    var adminAdvertisement1 : AdminAdvertisement!
    var adminAdvertisement2 : AdminAdvertisement!
    var adminAdvertisement3 : AdminAdvertisement!
    
    
    override func setUp(){
        dataAccess = AdminDataAccess()
        adminAdvertisementsViewModel = AdminAdvertisementsListViewModel(dataAccess: dataAccess)
        
        adminAdvertisement1 = AdminAdvertisement(advertisementId: "112233", advertisementPropertyLatitude: "31.76", advertisementPropertyLongitude: "33.11", advertisementPropertyLocation: "Mansoura", advertisementType: "Rent", advertisemetentUserId: "123", advertisementPropertyAmenities: [""], advertisementPropertyBathRooms: "1", advertisementPropertyBeds: "1", advertisementCountry: "Mansoura", advertisementDate: "2020", advertisementPropertyDescription: "Nice", advertismentsPropertyImages: [""], advertisementPaymentType: "Free", adevertisementPhone: "111", advertisementPropertyPrice: "150", advertisementPropertyType: "Room", advertisementPropertySize: "100")
        
        adminAdvertisement2 = AdminAdvertisement(advertisementId: "445566", advertisementPropertyLatitude: "31.76", advertisementPropertyLongitude: "33.11", advertisementPropertyLocation: "Cairo", advertisementType: "Rent", advertisemetentUserId: "123", advertisementPropertyAmenities: [""], advertisementPropertyBathRooms: "1", advertisementPropertyBeds: "1", advertisementCountry: "Cairo", advertisementDate: "2020", advertisementPropertyDescription: "Nice", advertismentsPropertyImages: [""], advertisementPaymentType: "Free", adevertisementPhone: "111", advertisementPropertyPrice: "150", advertisementPropertyType: "Room", advertisementPropertySize: "100")
        
        adminAdvertisement3 = AdminAdvertisement(advertisementId: "778899", advertisementPropertyLatitude: "31.76", advertisementPropertyLongitude: "33.11", advertisementPropertyLocation: "Portsaid", advertisementType: "Rent", advertisemetentUserId: "123", advertisementPropertyAmenities: [""], advertisementPropertyBathRooms: "1", advertisementPropertyBeds: "1", advertisementCountry: "Cairo", advertisementDate: "2020", advertisementPropertyDescription: "Nice", advertismentsPropertyImages: [""], advertisementPaymentType: "premium", adevertisementPhone: "111", advertisementPropertyPrice: "150", advertisementPropertyType: "Room", advertisementPropertySize: "100")
    }
    
    override func tearDown() {
        dataAccess = nil
        adminAdvertisementsViewModel = nil
        adminAdvertisement1 = nil
        adminAdvertisement2 = nil
        adminAdvertisement3 = nil
    }
    
    func testPopulateAdvertisements(){
        let expectationObj = expectation(description: "Waiting For response...")
        adminAdvertisementsViewModel.populateAdvertisements(){(totalAdvertisementsNumber) in
            expectationObj.fulfill()
            XCTAssertEqual(totalAdvertisementsNumber, self.adminAdvertisementsViewModel.adminFreeAdvertisementsList.count + self.adminAdvertisementsViewModel.adminPremiumAdvertisementsList.count)
            XCTAssertEqual(self.adminAdvertisementsViewModel.adminAdvertisementsViewList.count, self.adminAdvertisementsViewModel.adminFreeAdvertisementsList.count)
            
        }
        waitForExpectations(timeout: 15)
    }
    
    func testFilter(){
        let adminAdvertisements = [adminAdvertisement1!,adminAdvertisement2!,adminAdvertisement3!]
        adminAdvertisementsViewModel.filter(allAdvertisementsData: adminAdvertisements)
        XCTAssertEqual(adminAdvertisementsViewModel.adminFreeAdvertisementsList.count, 2)
        XCTAssertEqual(adminAdvertisementsViewModel.adminPremiumAdvertisementsList.count, 1)
    }
    
    func testGetAdvertisementsByType(){
        let advertisementModel1 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement1)
        let advertisementModel2 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement2)
        let advertisementModel3 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement3)
        adminAdvertisementsViewModel.adminFreeAdvertisementsList.append(advertisementModel1)
        adminAdvertisementsViewModel.adminFreeAdvertisementsList.append(advertisementModel2)
        adminAdvertisementsViewModel.adminPremiumAdvertisementsList.append(advertisementModel3)
        
        adminAdvertisementsViewModel.getAdvertisementsByType(type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList[0].advertisementId, adminAdvertisementsViewModel.adminFreeAdvertisementsList[0].advertisementId)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, adminAdvertisementsViewModel.adminFreeAdvertisementsList.count)
        
        adminAdvertisementsViewModel.getAdvertisementsByType(type: 1)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList[0].advertisementId, adminAdvertisementsViewModel.adminPremiumAdvertisementsList[0].advertisementId)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, adminAdvertisementsViewModel.adminPremiumAdvertisementsList.count)
    }
    
}

