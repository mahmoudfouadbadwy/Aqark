//
//  ReviewCell.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/31/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {

    @IBOutlet weak var reviewerUserNameLabel: UILabel!
    @IBOutlet weak var reviewContentTextView: UITextView!
   
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      reviewerUserNameLabel.textColor = UIColor(rgb: 0x1d3557)
        
    }

}
