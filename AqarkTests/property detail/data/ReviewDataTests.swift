//
//  ReviewDataTests.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark

class ReviewDataTests: XCTestCase {

    var reviewData: ReviewData!
    override func setUp() {
        reviewData = ReviewData()
    }
    
    func testGetAdvertisementReviews(){
         let expectationObj = expectation(description: "Waiting for reviews ...")
        reviewData.getAdvertisementReviews(id: "-MA16-T80n1xqodilijf") { (reviewsResult) in
                expectationObj.fulfill()
            if(reviewsResult != nil){
                XCTAssertNotNil(reviewsResult)
                for review in reviewsResult{
                    XCTAssertNotNil(review.advertisementId)
                    XCTAssertNotNil(review.reviewContent)
                    XCTAssertNotNil(review.userId)
                    XCTAssertNotNil(review.userName)
                    XCTAssertNotNil(review.userImage)
                }
            }else{
                XCTAssertNil(reviewsResult,"reviews exist")
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    func testGetUserDetails(){
        let expectationObj = expectation(description: "Waiting for user review ...")
        reviewData.getUserDetails(id: "8wnSEXCKodNSLQDZ3mAHCOt9RfD3") { (userReview) in
            expectationObj.fulfill()
            if(userReview != nil){
                XCTAssertNotNil(userReview)
             
                XCTAssertNotNil(userReview.userImage)
                XCTAssertNotNil(userReview.userName)
              
            }else{
                XCTAssertNil(userReview,"user review exist")
            }
        }
        waitForExpectations(timeout: 30)
    }
    
    override func tearDown() {
         reviewData=nil
    }

}

