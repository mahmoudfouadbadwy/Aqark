//
//  RatingExtenesion.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension AgentPropertiesView{
    
    func setupAgentRate(){
        rate.didFinishTouchingCosmos = {[weak self]
            rating in
            print(rating)
            self?.rate.isHidden = true
            self?.rateLabel.text = "Thank You"
        }
    }
    
}
