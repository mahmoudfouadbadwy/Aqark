//
//  extensionSegment.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/27/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension AddAdvertisementViewController{
    
//MARK:- func to Config segment
   
   @IBAction func selectAdvertisementType(_ sender: UISegmentedControl) {
       switch sender.selectedSegmentIndex {
       case 0:
        advertisementType = "Rent".localize
       case 1:
        advertisementType = "Buy".localize
       default:
           print("error")
       }
       
       updatePlaceholderForPriceTextFeild()
   }
    
    
   func updatePlaceholderForPriceTextFeild(){
       
    if advertisementType == "Rent".localize
       {
           switch propertyType {
           case "Apartment":
               priceTxtField.placeholder = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "500").1  + "EGP".localize
           case "Villa":
               priceTxtField.placeholder = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "5000").1  + "EGP".localize
           case "Room":
               priceTxtField.placeholder = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "200").1  + "EGP".localize
           default:
               print("noselection")
           }
           
       }else{
           switch propertyType {
           case "Apartment":
               priceTxtField.placeholder = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "50000").1  + "EGP".localize
           case "Villa":
               priceTxtField.placeholder = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "500000").1  + "EGP".localize
           case "Room":
               priceTxtField.placeholder = "minimum price is".localize + Localization.convertNumbers(lang: "lang".localize, stringNumber: "10000").1  + "EGP".localize
           default:
               print("noselection")
           }
           
       }
   }
    
    
}
