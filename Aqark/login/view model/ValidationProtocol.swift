//
//  ValidationProtocol.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/13/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

protocol ValidationProtocol {
    var brokenRules : [LoginBrokenRule] {get set}
    var isValid : Bool {mutating get}
    
}
