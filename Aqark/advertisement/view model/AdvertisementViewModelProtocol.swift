//
//  FileAddAdvertisementViewModelProtocol.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation



protocol AddAdvertisementViewModelProtocol {
    var borkenRule : [AddAdvertisementBrokenRule] {get set}
    var isValid : Bool{get}
}
