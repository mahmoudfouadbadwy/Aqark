//
//  AdminUsersListViewModelTests.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class AdminUsersListViewModelTests: XCTestCase {
    
    var adminUsersViewModel : AdminUsersListViewModel!
    var adminDataAccess : AdminDataAccess!
    var adminUser1 : AdminUser!
    var adminUser2 : AdminUser!
    var adminUser3 : AdminUser!
    

    override func setUp() {
        adminDataAccess = AdminDataAccess()
        adminUsersViewModel = AdminUsersListViewModel(dataAccess: adminDataAccess)
        adminUser1 = AdminUser(userId: "1", userName: "Zeyad", userEmail: "Zeyad@gmail.com", userPhone: "", userCountry: "Mansoura", userCompany: "", userRole: "user", userRating: 5.0, userExperience: "3", userImage: "", isBanned: false)
        adminUser2 = AdminUser(userId: "2", userName: "Fouad", userEmail: "Fouad@gmail.com", userPhone: "", userCountry: "Portsaid", userCompany: "ITI", userRole: "Lawyer", userRating: 5.0, userExperience: "", userImage: "", isBanned: false)
        adminUser3 = AdminUser(userId: "3", userName: "Saeed", userEmail: "Saeed@gmail.com", userPhone: "", userCountry: "Arish", userCompany: "ITI", userRole: "user", userRating: 5.0, userExperience: "", userImage: "", isBanned: false)
    }
    
    override func tearDown() {
        adminDataAccess = nil
        adminUsersViewModel = nil
        adminUser1 = nil
        adminUser2 = nil
        adminUser3 = nil
    }
    
    func testPopulateUsers(){
        let expectationObj = expectation(description: "Waiting For response...")
        adminUsersViewModel.populateUsers {_ in
            expectationObj.fulfill()
            XCTAssertEqual(self.adminUsersViewModel.adminUsersViewList.count, self.adminUsersViewModel.adminUsersList.count)
        }
        
        waitForExpectations(timeout:15)
    }
    
    func testFilter(){
        let adminUsers = [adminUser1!,adminUser2!,adminUser3!]
        adminUsersViewModel.filter(allUsersData: adminUsers)
        XCTAssertEqual(adminUsersViewModel.adminUsersList.count, 2)
        XCTAssertNotEqual(adminUsersViewModel.adminUsersList.count, 0)
        XCTAssertEqual(adminUsersViewModel.adminLawyersList.count, 1)
        XCTAssertEqual(adminUsersViewModel.adminInteriorDesignersList.count, 0)
    }
    
    func testgetUsersByType(){
        let adminUserViewModel1 = AdminUserViewModel(adminUser: adminUser1!)
        let adminUserViewModel2 = AdminUserViewModel(adminUser: adminUser2!)
        let adminUserViewModel3 = AdminUserViewModel(adminUser: adminUser3!)
        adminUsersViewModel.adminUsersList.append(adminUserViewModel1)
        adminUsersViewModel.adminUsersList.append(adminUserViewModel3)
        adminUsersViewModel.adminLawyersList.append(adminUserViewModel2)
        
        adminUsersViewModel.getUsersByType(type: 0)
        XCTAssertTrue(adminUsersViewModel.adminUsersViewList[0].userId == adminUsersViewModel.adminUsersList[0].userId)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, adminUsersViewModel.adminUsersList.count)
        
        adminUsersViewModel.getUsersByType(type: 1)
        XCTAssertTrue(adminUsersViewModel.adminUsersViewList[0].userId == adminUsersViewModel.adminLawyersList[0].userId)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, adminUsersViewModel.adminLawyersList.count)
        
        adminUsersViewModel.getUsersByType(type: 2)
        XCTAssertTrue(adminUsersViewModel.adminUsersViewList.count == 0)
    }
    
    func testGetFilteredUsers(){
        let adminUserViewModel1 = AdminUserViewModel(adminUser: adminUser1!)
        let adminUserViewModel2 = AdminUserViewModel(adminUser: adminUser2!)
        let adminUserViewModel3 = AdminUserViewModel(adminUser: adminUser3!)
        adminUsersViewModel.adminUsersList.append(adminUserViewModel1)
        adminUsersViewModel.adminUsersList.append(adminUserViewModel3)
        adminUsersViewModel.adminLawyersList.append(adminUserViewModel2)
        
        var searchText = "Z"
        adminUsersViewModel.getFilteredUsers(type: 0, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 1)
        XCTAssertTrue(adminUsersViewModel.adminUsersViewList.contains(where: { (user) -> Bool in
            user.userName == "Zeyad"
        }))
        XCTAssertFalse(adminUsersViewModel.adminUsersViewList.contains(where: { (user) -> Bool in
            user.userName == "Saeed"
        }))
        
        searchText = "F"
        adminUsersViewModel.getFilteredUsers(type: 0, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 0)
        
        searchText = "F"
        adminUsersViewModel.getFilteredUsers(type: 1, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 1)
        XCTAssertTrue(adminUsersViewModel.adminUsersViewList.contains(where: { (user) -> Bool in
            user.userName == "Fouad"
        }))
     
        
        searchText = "S"
        adminUsersViewModel.getFilteredUsers(type: 1, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 0)
        
        searchText = "a"
        adminUsersViewModel.getFilteredUsers(type: 2, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 0)
        
        searchText = ""
        adminUsersViewModel.getFilteredUsers(type:0, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 2)
        adminUsersViewModel.getFilteredUsers(type:1, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 1)
        adminUsersViewModel.getFilteredUsers(type:2, searchText: searchText)
        XCTAssertEqual(adminUsersViewModel.adminUsersViewList.count, 0)
    }
}

