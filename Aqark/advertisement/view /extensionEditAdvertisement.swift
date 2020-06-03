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
        addAdvertisementVM = AddAdvertisementViewModel(editDataSource : editAdvertisementDataSource)
        addAdvertisementVM.fetchAdvertisement { (myValue) in
     
            self.dateOfAdvertisement = myValue.date
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MM-dd HH:mm"

            let currentDate = Date()
            let lastTimeForEdit = formatter.date(from: myValue.date!)!.addingTimeInterval(24*60*60)


            if (currentDate <= lastTimeForEdit)
            {
                
                self.priceTxtField.text = myValue.price
                self.sizeTxtField.text = myValue.size
                self.phoneTxtField.text = myValue.phone
                self.BedroomsTxtField.text = myValue.bedRooms
                self.BathroomTxtField.text = myValue.bathRooms
                self.countyTxtField.text = myValue.country
                self.describtionTxtView.text = myValue.description
                if let address = myValue.Address{
                    self.addressTxtField.text = address["location"]
                    self.latitude = address["latitude"] ?? ""
                    self.longitude = address["longitude"] ?? ""
                }
                
                if let advertisementType = myValue.AdvertisementType{
                    self.advertisementType = advertisementType
                    if(self.advertisementType == "Rent"){
                        self.segment.selectedSegmentIndex = 0
                    }else{
                        self.segment.selectedSegmentIndex = 1
                    }
                }
                
                
                if let propertyType = myValue.propertyType{
                    self.propertyType = propertyType
                    if(self.propertyType == "Apartment"){
                        self.pickerView.selectRow(2, inComponent: 0, animated: true)
                    }
                    else if(self.propertyType == "Villa"){
                        self.pickerView.selectRow(2, inComponent: 0, animated: true)
                    }
                    else{
                        self.pickerView.selectRow(2, inComponent: 0, animated: true)
                    }
                }
                
                if case self.payment = myValue.payment{
                    if (self.payment == "free"){
                        self.switchButton.isOn = true
                    }else{
                        self.switchButton.isOn = false
                    }
                }
                
                if let bedroom = myValue.bedRooms{
                    self.bedRoomStepper.value = Double(bedroom)!
                }
                
                if let bathroom = myValue.bathRooms{
                      self.bathRoomStepper.value = Double(bathroom)!
                }
                
                if let myValue = myValue.amenities
                {
                    for i in myValue
                    {
                        let tag = self.selectEditAmenitiesValue(value: i)
                        self.amentiesButton[tag].setImage(UIImage(named: "advertisement_check"), for: .normal)
                        self.selectAmenitiesDic[tag] = i
                    }
                }
                
                if let urlImages = myValue.images{
                    self.urlImages = urlImages
                    self.collectionView.reloadData()
                }

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