//
//  ServicesCollectionViewCell.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Cosmos

class ServicesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var RightView: UIView!
    @IBOutlet weak var serviceUserImage: UIImageView!
    @IBOutlet weak var serviceUserName: UILabel!
    @IBOutlet weak var serviceUserCompany: UILabel!
    @IBOutlet weak var serviceUserLocation: UILabel!
    @IBOutlet weak var serviceUserExperience: UILabel!
    @IBOutlet weak var serviceUserRating: CosmosView!
    @IBOutlet weak var rateMeView: CosmosView!
    @IBOutlet weak var rateMeButton: UIButton!
    @IBOutlet weak var dialerButton: UIButton!
    @IBOutlet weak var serviceCompany: UIView!
    @IBOutlet weak var serviceExperience: UIView!
    var serviceUserCellIndex : IndexPath!
    weak var serviceUserDelegate : ServiceUsersCollectionDelegate!
    var loggedDialerButtonCenterXAnchor: NSLayoutConstraint!
    var loggedDialerButtonWidthAnchor : NSLayoutConstraint!
    var unLoggedDialerButtonCenterXAnchor : NSLayoutConstraint!
    var unLoggedDialerButtonWidthAnchor : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loggedDialerButtonCenterXAnchor = dialerButton.centerXAnchor.constraint(equalTo: RightView.centerXAnchor)
        loggedDialerButtonWidthAnchor = dialerButton.widthAnchor.constraint(equalTo: rateMeButton.widthAnchor)
        unLoggedDialerButtonCenterXAnchor = dialerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        unLoggedDialerButtonWidthAnchor = dialerButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        
        dialerButton.layer.borderColor = UIColor(rgb: 0x1d3557).cgColor
        dialerButton.layer.borderWidth = 1
        rateMeButton.layer.borderColor = UIColor(rgb: 0xe63946).cgColor
        rateMeButton.layer.borderWidth = 1
        
        serviceUserRating.settings.fillMode = .precise
        rateMeView.settings.fillMode = .precise
        rateMeView.didFinishTouchingCosmos = {rating in
            self.rateMeButton.alpha = 0
            self.rateMeButton.isHidden = false
            UIView.animate(withDuration: 0.6, animations: {[weak self] in
                self?.rateMeView.alpha = 0
                self?.rateMeButton.alpha = 1
            }) { [weak self] (finished) in
                self?.rateMeView.isHidden = finished
                self?.serviceUserDelegate.rateServiceUserDelegate(at: self!.serviceUserCellIndex,rate:rating)
            }
        }
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
        if(serviceUserDelegate.checkLoggedUserDelegate()){
            setLoggedButtons()
        }else{
            setUnLoggedButtons()
        }
        
        if(serviceUserCompany.text == ""){
            serviceCompany.isHidden = true
        }else if(serviceUserCompany.text != "" && serviceCompany.isHidden == true){
            serviceCompany.isHidden = false
        }
        
        if(serviceUserExperience.text == " exp years."){
            serviceExperience.isHidden = true
        }else if(serviceExperience.isHidden == true && serviceUserExperience.text != " exp years."){
            serviceExperience.isHidden = false
        }
    }
    
    @IBAction func rateServiceUser(_ sender: Any) {
        
        if(serviceUserDelegate.checkConnectionDelegate()){
            let sameUser = serviceUserDelegate.checkServiceUserDelegate(at:serviceUserCellIndex)
            if(!sameUser){
                self.rateMeView.alpha = 0
                self.rateMeView.isHidden = false
                UIView.animate(withDuration: 0.6, animations: {
                    self.rateMeButton.alpha = 0
                    self.rateMeView.alpha = 1
                }) { (finished) in
                    self.rateMeButton.isHidden = finished
                }
            }
        }
    }
    
    @IBAction func callServiceUser(_ sender: Any) {
        serviceUserDelegate.callServiceUserDelegate(at: serviceUserCellIndex)
    }
    
    private func setUnLoggedButtons(){
        rateMeButton.isHidden = true
        loggedDialerButtonCenterXAnchor.isActive = false
        loggedDialerButtonWidthAnchor.isActive = false
        unLoggedDialerButtonCenterXAnchor.isActive = true
        unLoggedDialerButtonWidthAnchor.isActive = true
        
    }
    
    private func setLoggedButtons(){
        rateMeButton.isHidden = false
        loggedDialerButtonCenterXAnchor.isActive = true
        loggedDialerButtonWidthAnchor.isActive = true
        unLoggedDialerButtonCenterXAnchor.isActive = false
        unLoggedDialerButtonWidthAnchor.isActive = false
    }
}
