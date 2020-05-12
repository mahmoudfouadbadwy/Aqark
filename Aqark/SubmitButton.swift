//
//  SubmitButton.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

@IBDesignable class SubmitButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        
    }
    
    @IBInspectable var rounded : Bool = false{
        didSet{
            updateCornerRadius()
        }
    }

    func updateCornerRadius(){
        layer.cornerRadius = rounded ? 10 : 0
    }
}
