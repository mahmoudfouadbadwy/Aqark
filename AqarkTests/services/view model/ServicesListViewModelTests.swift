//
//  ServicesListViewModelTests.swift
//  AqarkTests
//
//  Created by ZeyadEl3ssal on 6/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class ServicesListViewModelTests: XCTestCase {
    
    var servicesViewModel : ServicesListViewModel!
    var dataAccess : ServiceDataAccess!
    var serviceUser1 : ServiceUser!
    var serviceUser2 : ServiceUser!
    var serviceUser3 : ServiceUser!
    var serviceUser4 : ServiceUser!
    
    override func setUp(){
        dataAccess = ServiceDataAccess()
        servicesViewModel = ServicesListViewModel(dataAccess: dataAccess)
        serviceUser1 = ServiceUser(userId: "1", userName: "Zeyad", userEmail: "Zeyad@gmail.com", userPhone: "", userCountry: "Mansoura,Egypt", userCompany: "", userRole: "user", userServiceRating: 5.0, userExperience: "3", userImage: "")
        serviceUser2 = ServiceUser(userId: "2", userName: "Fouad", userEmail: "Fouad@gmail.com", userPhone: "", userCountry: "Portsaid,Egypt", userCompany: "", userRole: "lawyer", userServiceRating: 5.0, userExperience: "3", userImage: "")
        serviceUser3 = ServiceUser(userId: "3", userName: "Saeed", userEmail: "Saeed@gmail.com", userPhone: "", userCountry: "Arish,Egypt", userCompany: "", userRole: "lawyer", userServiceRating: 5.0, userExperience: "3", userImage: "")
        serviceUser4 = ServiceUser(userId: "4", userName: "Ahmed", userEmail: "Ahmed@gmail.com", userPhone: "", userCountry: "Tanta,Egypt", userCompany: "", userRole: "interior designer", userServiceRating: 5.0, userExperience: "3", userImage: "")
    }
    
    override func tearDown(){
        dataAccess = nil
        servicesViewModel = nil
    }
    
    func testGetServiceUsers(){
        let expectationObj = expectation(description: "Waiting For response...")
        servicesViewModel.getServiceUsers {
            expectationObj.fulfill()
            XCTAssertNotNil(self.servicesViewModel.serviceLawyersList)
            XCTAssertNotNil(self.servicesViewModel.serviceInteriorDesignersList)
        }
        waitForExpectations(timeout: 15)
    }
    
    func testFilterUsers(){
        let servicesUsers = [serviceUser1!,serviceUser2!,serviceUser3!,serviceUser4!]
        servicesViewModel.filterUsers(serviceUsers: servicesUsers)
        XCTAssertEqual(servicesViewModel.serviceLawyersList.count, 2)
        XCTAssertEqual(servicesViewModel.serviceInteriorDesignersList.count, 1)
    }
    
    func testGetServiceUsersList(){
        let setviceUserModel2 = ServiceUserViewModel(serviceUser: serviceUser2)
        let setviceUserModel3 = ServiceUserViewModel(serviceUser: serviceUser3)
        let setviceUserModel4 = ServiceUserViewModel(serviceUser: serviceUser4)
        servicesViewModel.serviceLawyersList.append(setviceUserModel2)
        servicesViewModel.serviceLawyersList.append(setviceUserModel3)
        servicesViewModel.serviceInteriorDesignersList.append(setviceUserModel4)


        servicesViewModel.getServiceUsersList(serviceUserRole: "Lawyers", country: "Mansoura")
        XCTAssertEqual(servicesViewModel.serviceUsersViewList.count, 0)
        
        servicesViewModel.getServiceUsersList(serviceUserRole: "Lawyers", country: "Portsaid")
        XCTAssertEqual(servicesViewModel.serviceUsersViewList.count, 1)
        XCTAssertTrue(servicesViewModel.serviceUsersViewList.contains(where: { (serviceUser) -> Bool in
            serviceUser.serviceUserName == "Fouad"
        }))
        
        servicesViewModel.getServiceUsersList(serviceUserRole: "Lawyers", country: "Arish")
        XCTAssertEqual(servicesViewModel.serviceUsersViewList.count, 1)
        XCTAssertTrue(servicesViewModel.serviceUsersViewList.contains(where: { (serviceUser) -> Bool in
            serviceUser.serviceUserName == "Saeed"
        }))
        
        servicesViewModel.getServiceUsersList(serviceUserRole: "Designers", country: "Tanta")
              XCTAssertEqual(servicesViewModel.serviceUsersViewList.count, 1)
              XCTAssertTrue(servicesViewModel.serviceUsersViewList.contains(where: { (serviceUser) -> Bool in
                  serviceUser.serviceUserName == "Ahmed"
              }))
    }
    
    func testCheckServiceUser(){
        let isServiceUser = servicesViewModel.checkServiceUser(serviceUserId: "1")
        XCTAssertFalse(isServiceUser)
    }
    
    func testCheckLoggedUser(){
        let isUserLogged = servicesViewModel.checkLoggedUser()
        XCTAssertFalse(isUserLogged)
    }
    
    func testGetGovernorate(){
      var governorate = servicesViewModel.getGovernorate("Mansoura")
       XCTAssertTrue(governorate == "Mansoura")
        governorate = servicesViewModel.getGovernorate("Portsaid,Egypt")
        XCTAssertTrue(governorate == "Portsaid")
        governorate = servicesViewModel.getGovernorate("Ras-elbar,Domyat,Egypt")
        XCTAssertTrue(governorate == "Domyat")
    }
}
