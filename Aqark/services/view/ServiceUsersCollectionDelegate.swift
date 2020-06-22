//
//  ServiceUsersCollectionDelegate.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/1/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

protocol ServiceUsersCollectionDelegate : class{
    func rateServiceUserDelegate(at indexPath : IndexPath,rate:Double)
    func checkServiceUserDelegate(at indexPath : IndexPath) -> Bool
    func checkLoggedUserDelegate() -> Bool
    func callServiceUserDelegate(at indexPath: IndexPath)
    func checkConnectionDelegate() -> Bool
}

