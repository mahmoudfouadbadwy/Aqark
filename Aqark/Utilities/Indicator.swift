//
//  Indicator.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 6/1/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
fileprivate var indicatorView:UIView?
extension UIViewController{
    func showActivityIndicator() {
        
        indicatorView = UIView(frame: self.view.bounds)
        indicatorView?.backgroundColor = UIColor.init(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.center = (indicatorView?.center)!
        indicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        indicator.startAnimating()
        indicatorView?.addSubview(indicator)
        self.view.addSubview(indicatorView!)
    }
    
    func stopActivityIndicator(){
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
    
}
