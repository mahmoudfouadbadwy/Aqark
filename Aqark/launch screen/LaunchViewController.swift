//
//  LaunchViewController.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import SwiftyGif
import ImageIO

class LaunchViewController: UIView {
    
    let logoGifImageView = UIImageView(gifImage: UIImage(gifName: "logoGif"), loopCount: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(logoGifImageView)
        logoGifImageView.frame = CGRect(x: frame.size.height / 2, y: frame.size.width  / 2, width: 280.0, height: 280.0)
   
    }
}

