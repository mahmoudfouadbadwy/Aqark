//
//  PurchaseManager.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 6/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//


typealias CompletionHandler = (_ success : Bool) -> ()
import Foundation
import StoreKit


class PurchaseManager : NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let instance = PurchaseManager()
    let premiumAdvertisementIAP = "com.ITI.Aqark.premiumadvertisement"
    var productsRequest : SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete : CompletionHandler?
    
    func fetchProducts(){
        let productIds = NSSet(object: premiumAdvertisementIAP) as! Set<String>
        productsRequest = SKProductsRequest(productIdentifiers: productIds)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func purchasePremiumAdvertisement(onComplete : @escaping CompletionHandler){
        if SKPaymentQueue.canMakePayments() && products.count > 0{
            transactionComplete = onComplete
            let premiumAdvertisementProduct = products[0]
            let payment = SKPayment(product: premiumAdvertisementProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)

            
        }else{
            onComplete(false)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState{
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == premiumAdvertisementIAP{
                    print("success transaction")
                    transactionComplete?(true)
                }
             break
            case .failed:
                 SKPaymentQueue.default().finishTransaction(transaction)
                 transactionComplete?(false)
                break
            case .restored:
                 SKPaymentQueue.default().finishTransaction(transaction)
                 transactionComplete?(true)
                break
           
            default:
                 transactionComplete?(false)
                break
            }
            
        }
        
    }
    

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            print(response.products.debugDescription)
            products = response.products
        }
    }
  
}
