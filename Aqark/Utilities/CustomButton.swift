//
//  SubmitButton.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    @IBInspectable var rounded : Bool = false{
        didSet{
            updateCornerRadius()
        }
    }

    private func updateCornerRadius(){
        layer.cornerRadius = rounded ? 10 : 0
    }
    
    @IBInspectable var backColor:Bool = false{
        didSet{
            setButtonBackground()
        }
    }
    
    private func setButtonBackground()
    {
        self.backgroundColor = UIColor(rgb: 0x1d3557)
    }
}
