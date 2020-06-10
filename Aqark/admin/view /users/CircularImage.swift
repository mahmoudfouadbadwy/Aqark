//
//  CircularImage.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

//class CircularImage: UIImageView {
//
//
//    override func layoutSubviews() {
//        layer.cornerRadius = frame.size.width / 2
//        layer.masksToBounds = true
//        layer.borderColor = UIColor.clear.cgColor
//        layer.borderWidth = 1
//    }
//
//
//    /*
//     // Only override draw() if you perform custom drawing.
//     // An empty implementation adversely affects performance during animation.
//     override func draw(_ rect: CGRect) {
//     // Drawing code
//     }
//     */
//
//}

extension UIImageView{
    func circularImage(){
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 1
    }
}
