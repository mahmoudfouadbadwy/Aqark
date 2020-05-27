//
//  extensionEditAdvertisement.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/27/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit


//MARK: - extenion Edit advertisement


extension AddAdvertisementViewController {
    
    
    func reloadViewData(){
        
        saveAndEditButton.setTitle("Edit", for: .normal)
        editAdvertisementDataSource = EditAdvertisementDataSource(advertisementId: advertisementId)
        editAdvertisementDataSource.fetchAdvertisement { (myValue) in
            
            self.dateOfAdvertisement = myValue.date
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            let currentDate = Date()
            let lastTimeForEdit = formatter.date(from: myValue.date!)!.addingTimeInterval(24*60*60)
            
            
            if (currentDate <= lastTimeForEdit)
            {
                print("can make change")
                
                // put all in feilds
                self.priceTxtField.text = myValue.price
                self.sizeTxtField.text = myValue.size
                self.addressTxtField.text = myValue.Address!["location"]
                self.phoneTxtField.text = myValue.phone
                self.BedroomsTxtField.text = myValue.bedRooms
                self.BathroomTxtField.text = myValue.bathRooms
                self.countyTxtField.text = myValue.country
                self.describtionTxtView.text = myValue.description
                
                // segment
                self.advertisementType = myValue.AdvertisementType!
                if(self.advertisementType == "Rent"){
                    self.segment.selectedSegmentIndex = 0
                }else{
                    self.segment.selectedSegmentIndex = 1
                }
                //picker
                self.propertyType = myValue.propertyType!
                print(self.propertyType)
                if(self.propertyType == "Apartment"){
                    print(self.propertyType)
                    self.pickerView.selectRow(2, inComponent: 0, animated: true)
                }
                else if(self.propertyType == "Villa"){
                    print(self.propertyType)
                    self.pickerView.selectRow(2, inComponent: 0, animated: true)
                }
                else{
                    print(self.propertyType)
                    self.pickerView.selectRow(2, inComponent: 0, animated: true)
                }
                
                
                //switchButton
                self.payment = myValue.payment!
                if (self.payment == "free"){
                    self.switchButton.isOn = true
                }else{
                    self.switchButton.isOn = false
                }
                
                // bedroom and bathroom stepper
                self.bedRoomStepper.value = Double(myValue.bedRooms!)!
                self.bathRoomStepper.value = Double(myValue.bathRooms!)!
                
                
                
                //animaities
                
                for i in myValue.amenities!
                {
                    let tag = self.selectEditAmenitiesValue(value: i)
                    self.amentiesButton[tag].setImage(UIImage(named: "advertisement_check"), for: .normal)
                    self.selectAmenitiesDic[tag] = i
                }
                
                //image
                
                self.urlImages = myValue.images!
                print(self.urlImages)
                self.collectionView.reloadData()
                
                
            }else{
                print("can't make change you have only  one day to change ")
            }
            
            
        }
    }
    
    
       func selectEditAmenitiesValue(value : String)->Int{
           var tag = 0
           switch value {
           case "Furnished":
               tag = 0
           case "Shared Spa":
               tag = 1
           case "Central A/C":
               tag = 2
           case "Maids Room":
               tag = 3
           case "Security":
               tag = 4
           case "Kitchen Appliances":
               tag = 5
           case "Networked":
               tag = 6
           case "Covered Parking":
               tag = 7
           case "Pets Allowed":
               tag = 8
           case "Barbecue Area":
               tag = 9
           case "Balcony":
               tag = 10
           case "Walk-in Closet":
               tag = 11
           case "Study":
               tag = 12
           case "Private garden":
               tag = 13
           case "Children's Play Area":
               tag = 14
           default:
               print("switch problem")
           }
           return tag
       }
       
       
       
       
    
}
