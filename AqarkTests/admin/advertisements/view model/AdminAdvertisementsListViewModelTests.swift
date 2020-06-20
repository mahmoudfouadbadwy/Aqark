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
    
    func testGetFilteredAdvertisements(){
        
        let advertisementModel1 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement1)
        let advertisementModel2 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement2)
        let advertisementModel3 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement3)
        adminAdvertisementsViewModel.adminFreeAdvertisementsList.append(advertisementModel1)
        adminAdvertisementsViewModel.adminFreeAdvertisementsList.append(advertisementModel2)
        adminAdvertisementsViewModel.adminPremiumAdvertisementsList.append(advertisementModel3)
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "C", type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 1)
        XCTAssertTrue(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Cairo"
        }))
        XCTAssertFalse(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Mansoura"
        }))
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "M",type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 1)
        XCTAssertTrue(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Mansoura"
        }))
        XCTAssertFalse(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Cairo"
        }))
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "P", type: 1)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 1)
        XCTAssertTrue(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Portsaid"
        }))
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "z", type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 0)
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "z", type: 1)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 0)
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "112233", type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 1)
        XCTAssertTrue(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Mansoura"
        }))
        XCTAssertFalse(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Cairo"
        }))
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "445566", type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 1)
        XCTAssertTrue(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Cairo"
        }))
        XCTAssertFalse(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Mansoura"
        }))
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "778899", type: 1)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 1)
        XCTAssertTrue(adminAdvertisementsViewModel.adminAdvertisementsViewList.contains(where: { (advertisement) -> Bool in
            advertisement.advertisementPropertyAddress == "Portsaid"
        }))
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "999999", type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 0)
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "999999", type: 1)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 0)
        
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "", type: 0)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 2)
        
        adminAdvertisementsViewModel.getFilteredAdvertisements(searchText: "", type: 1)
        XCTAssertEqual(adminAdvertisementsViewModel.adminAdvertisementsViewList.count, 1)
    }
    
    func testGetReportedAdvertisementPaymentType(){
        let reportedAdvertisementModel1 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement1)
        let reportedAdvertisementModel2 = AdminAdvertisementViewModel(adminAdvertisment: adminAdvertisement3)
        
        adminAdvertisementsViewModel.adminFreeAdvertisementsList.append(reportedAdvertisementModel1)
        adminAdvertisementsViewModel.adminPremiumAdvertisementsList.append(reportedAdvertisementModel2)
        
        var paymentType = adminAdvertisementsViewModel.getReportedAdvertisementPaymentType(reportedAdvertisementId: reportedAdvertisementModel1.advertisementId)
        XCTAssertTrue(paymentType == "free")
        
        paymentType = adminAdvertisementsViewModel.getReportedAdvertisementPaymentType(reportedAdvertisementId: reportedAdvertisementModel2.advertisementId)
        XCTAssertTrue(paymentType == "premium")
        
        paymentType = adminAdvertisementsViewModel.getReportedAdvertisementPaymentType(reportedAdvertisementId:"99999")
        XCTAssertTrue(paymentType == "deleted")

        
    }
}

