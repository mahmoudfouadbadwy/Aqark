//
//  Launchview.swift
//  Aqark
//
//  Created by Mostafa Samir on 6/8/20.
//  Copyright © 2020 ITI. All rights reserved.
//
import UIKit
import SwiftyGif
import ImageIO

class LaunchViewController: UIViewController {
    
    private let logoAnimationView = LogoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Color.primary
        logoAnimationView.logoGifImageView.center = CGPoint(x: view.frame.size.width  / 2,
                                          y: view.frame.size.height / 2)
        view.addSubview(logoAnimationView)
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
}

extension LaunchViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}
