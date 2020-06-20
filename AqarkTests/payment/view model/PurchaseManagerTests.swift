//
//  PurchaseManagerTests.swift
//  AqarkTests
//
//  Created by Shorouk Mohamed on 6/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import XCTest
@testable import Aqark
import StoreKit


class PurchaseManagerTests: XCTestCase {

    var purchaseManager : PurchaseManager!
    
    override func setUp(){
        purchaseManager = PurchaseManager()
    }
    
    func testFetchProducts(){
        purchaseManager.fetchProducts()
        XCTAssertNotNil(purchaseManager.productsRequest)
    }
    
    func testPurchasePremiumAdvertisement(){
        purchaseManager.purchasePremiumAdvertisement(){(completed) in
            if completed {
                XCTAssertTrue(completed)
            }else{
                XCTAssertFalse(completed)
            }
            
        }
    }
    

    override func tearDown(){
        purchaseManager = nil
    }



}
