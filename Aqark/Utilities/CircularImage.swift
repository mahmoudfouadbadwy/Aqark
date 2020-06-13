//
//  CircularImage.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class CircularImage: UIImageView {
    override func layoutSubviews() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 1
    }
}

