//
//  EditProfileProtocol.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

protocol EditProfileProtocol {
    var borkenRule : [EditProfileBrokenRule] {get set}
    var isValid : Bool{get}
}
