//
//  ReportViewModelTests.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class ReportViewModelTests: XCTestCase {
    
    var reportViewModel: ReportViewModel!
    
    override func setUp() {
        reportViewModel = ReportViewModel(dataAccess: ReportData())
    }
    
    func testCheckUserAuth(){
        XCTAssertFalse(reportViewModel.checkUserAuth()==true)
        
    }
    
    func testGetUserId(){
        XCTAssertTrue(reportViewModel.getUserId() == "","no user id")
    }

    override func tearDown() {
        reportViewModel = nil
    }

}
