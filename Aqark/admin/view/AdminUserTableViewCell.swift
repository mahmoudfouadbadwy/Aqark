//
//  AdminUserTableViewCell.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Cosmos

class AdminUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRating: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowAndBorderForCell(yourTableViewCell: self)
    }
    
    func shadowAndBorderForCell(yourTableViewCell : UITableViewCell){
    // SHADOW AND BORDER FOR CELL
    //yourTableViewCell.contentView.layer.cornerRadius = 5
    yourTableViewCell.contentView.layer.borderWidth = 0.5
    yourTableViewCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
    yourTableViewCell.contentView.layer.masksToBounds = true
    yourTableViewCell.layer.shadowColor = UIColor.gray.cgColor
    yourTableViewCell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    yourTableViewCell.layer.shadowRadius = 2.0
    yourTableViewCell.layer.shadowOpacity = 1.0
    yourTableViewCell.layer.masksToBounds = false
    yourTableViewCell.layer.shadowPath = UIBezierPath(roundedRect:yourTableViewCell.bounds, cornerRadius:yourTableViewCell.contentView.layer.cornerRadius).cgPath
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
