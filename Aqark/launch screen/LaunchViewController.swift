//
//  LaunchViewController.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage.gif(asset: "logoGif")

    }


}

extension UIImage {
    public class func gif(asset: String) -> UIImage? {
        if let asset = NSDataAsset(name: asset) {
            return UIImage.sd_image(withGIFData: asset.data)
        }
        return nil
    }
}
