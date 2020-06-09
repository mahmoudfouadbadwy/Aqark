//
//  KeyBoard.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 6/8/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension UIViewController{
    func setTappedGesture()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
}
