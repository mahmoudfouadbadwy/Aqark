//
//  extensionSelectAmenities.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/27/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit


//MARK: - func select Amenities value when you check boxs

extension AddAdvertisementViewController{
    
    
    @IBAction func selectAmenities(_ sender: UIButton) {
        
        if let myButtonImage = sender.currentImage, let buttonAppuyerImage = UIImage(named: "advertisement_uncheck.png"), myButtonImage.pngData() == buttonAppuyerImage.pngData()
        {
            sender.setImage(UIImage(named: "advertisement_check"), for: .normal)
            selectAmenitiesDic[sender.tag] = selectAmenitiesValue(tagNumber: sender.tag)
        }else{
            sender.setImage(UIImage(named: "advertisement_uncheck"), for: .normal)
            selectAmenitiesDic.removeValue(forKey: sender.tag)
        }
    }
    
    func selectAmenitiesValue(tagNumber : Int)-> String{
        var value:String = ""
        switch tagNumber {
        case 0:
            value = "Furnished".localize
        case 1:
            value = "Shared Spa".localize
        case 2:
            value = "Central A/C".localize
        case 3:
            value = "Maids Room".localize
        case 4:
            value = "Security".localize
        case 5:
            value = "Kitchen Appliances".localize
        case 6:
            value = "Networked".localize
        case 7:
            value = "Covered Parking".localize
        case 8:
            value = "Pets Allowed".localize
        case 9:
            value = "Barbecue Area".localize
        case 10:
            value = "Balcony".localize
        case 11:
            value = "Walk-in Closet".localize
        case 12:
            value = "Study".localize
        case 13:
            value = "Private garden".localize
        case 14:
            value = "Children's Play Area".localize
        default:
            print("switch problem")
        }
        return value
    }
    
}
