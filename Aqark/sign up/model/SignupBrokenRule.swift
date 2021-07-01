//
//  BrokenRules.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct SignUpBrokenRule {
    var name: String
    var message: String
    
}

protocol Validation {
    var brokenRules: [SignUpBrokenRule] {get set}
    var isValid: Bool {mutating get}
}
