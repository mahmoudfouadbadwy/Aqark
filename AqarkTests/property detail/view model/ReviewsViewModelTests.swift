//
//  ReviewsViewModelTests.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class ReviewsViewModelTests: XCTestCase {
    
    var reviewsViewModel: ReviewsViewModel!

    override func setUp(){
        reviewsViewModel = ReviewsViewModel(dataAccess: ReviewData())
    }
    
    func testCheckUserAuth(){
        XCTAssertFalse(reviewsViewModel.checkUserAuth()==true)
        
    }
    
    func testGetUserId(){
        XCTAssertTrue(reviewsViewModel.getUserId() == "","no user id")
    }
    
    func testPopulateAdvertisementReviews(){
        let expectationObj = expectation(description: "Waiting for advertisement review...")
        reviewsViewModel.populateAdvertisementReviews(id: "495858") { (reviewsResult) in
            expectationObj.fulfill()
            if(reviewsResult != nil){
                XCTAssertNotNil(reviewsResult)
                for review in reviewsResult{
                    XCTAssertNotNil(review.reviewContent)
                    XCTAssertNotNil(review.userName)
                    XCTAssertNotNil(review.userImage)
                }
            }else{
                XCTAssertNil(reviewsResult,"reviews exist")
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    override func tearDown() {
        reviewsViewModel=nil
        
    }

}
