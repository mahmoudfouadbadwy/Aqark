//
//  extensionTextFieldImageAndUnderline.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:CGRect(x: 10, y: 10, width: 20, height: 20))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame:CGRect(x: 20, y: 15, width: 40, height: 40))
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
    
}

