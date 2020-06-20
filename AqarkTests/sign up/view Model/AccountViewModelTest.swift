//
//  AccountViewModelTest.swift
//  AqarkTests
//
//  Created by Mahmoud Fouad on 6/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark
class AccountViewModelTest: XCTestCase {
    var accountVM:AccountViewModel!
    override func setUp() {
        accountVM = AccountViewModel(email: "mahmoud@gmail.com", password: "123456", confirmPassword: "123456", username: "mahmoud fouad")
    }

    override func tearDown() {
        accountVM = nil
    }

    func testValidateEmail(){
        XCTAssertNotNil(accountVM)
        XCTAssertNotEqual(accountVM.email,"")
        XCTAssertNotNil(accountVM.email)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        XCTAssertTrue(emailPred.evaluate(with: accountVM.email))
        XCTAssertTrue(accountVM.isValid)
    }
    
    func testValidatePassword()
    {
        XCTAssertNotNil(accountVM)
        XCTAssertNotEqual(accountVM.password,"")
        XCTAssertGreaterThan(accountVM.password.count, 5)
         XCTAssertTrue(accountVM.isValid)
    }
    
    func testValidateConfiremPassword()
    {
        XCTAssertNotNil(accountVM)
        XCTAssertNotEqual(accountVM.confirmPassword,"")
        XCTAssertEqual(accountVM.password, accountVM.confirmPassword)
        XCTAssertTrue(accountVM.isValid)
    }
    
    func testValidateUsername()
    {
        XCTAssertNotNil(accountVM)
        let usernameRegEX = "^(?=.{6,20}$)(?![0-9._])(?!.*[_.]{2})[a-zA-Z0-9._\\u0621-\\u064A ]+(?<![_.])$";
        let usernamePred = NSPredicate(format:"SELF MATCHES %@",usernameRegEX )
        XCTAssertTrue(usernamePred.evaluate(with: accountVM.username))
        XCTAssertTrue(accountVM.isValid)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
