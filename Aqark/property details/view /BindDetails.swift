//
//  BindDtails.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/24/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit
extension PropertyDetailView{
    func bindAdvertisementData(){
        if "lang".localize.elementsEqual("en"){
            self.dateOfAdvertisement.text = self.advertisementDetails.date
        }else{
            var date:String = ""
            let x = self.advertisementDetails.date.split(separator: " ")
            let y = x.first?.split(separator: "-")
            let z = x.last?.split(separator: ":")
            date.append(self.convertNumbers(lang: "lang".localize, stringNumber: String(z![0])).1 + ":")
            date.append(self.convertNumbers(lang: "lang".localize, stringNumber: String(z![1])).1 + "  ")
            date.append(self.convertNumbers(lang: "lang".localize, stringNumber: String(y![2])).1 + "-")
            date.append(self.convertNumbers(lang: "lang".localize, stringNumber: String(y![1])).1 + "-")
            date.append(self.convertNumbers(lang: "lang".localize, stringNumber: String(y![0])).1 + " ")
            self.dateOfAdvertisement.text = date
        }
        
        self.getImages(images: self.advertisementDetails.images, completion:self.setSliderImages)
        
        self.setPrice()
        self.setSpecification()
        self.address.text = self.advertisementDetails.location
        self.propertyType.text = self.advertisementDetails.propertyType.localize
        self.propertySize.text = self.convertNumbers(lang: "lang".localize, stringNumber: self.advertisementDetails.propertysize).1
        self.bedrooms.text = self.convertNumbers(lang: "lang".localize, stringNumber: self.advertisementDetails.bedroom).1
        self.bathrooms.text = self.convertNumbers(lang: "lang".localize, stringNumber: self.advertisementDetails.bathroom).1
        self.configureCallingButton()
        self.setUpAmenitiesCollection()
        self.username.text = self.agent.username
        self.company.text = self.agent.company
        self.setAgentRate()
        self.advertisementDescription.text = self.advertisementDetails.description
    }
    
    
    private func setPrice()
    {
        if self.advertisementDetails.advertismentType.elementsEqual("Rent")
        {
            self.price.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(self.advertisementDetails.price))).1 + "EGP/month".localize
        }
        else
        {
            self.price.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(self.advertisementDetails.price))).1 + "EGP".localize
        }
    }
    
    private func setSpecification()
    {
        
        if "lang".localize == "en"{
            self.specification.text = "\(self.advertisementDetails.propertyType.localize ) \("for".localize) \(self.advertisementDetails.advertismentType.localize ) \("in".localize) \(self.advertisementDetails.country.split(separator: ",")[1] )"
        }else{
            self.specification.text = "\(self.advertisementDetails.propertyType.localize ) \("for".localize)\(self.advertisementDetails.advertismentType.localize ) \("in".localize) \(self.advertisementDetails.country.localize )"
        }
    }
    
    private func setAgentRate()
    {
        let rates = self.agent.rate
        var agentRate:Double = 0
        for rate in rates ?? ["":0.0]
        {
            agentRate += rate.value
        }
        if rates?.count ?? 0>0{
            agentRate /= Double(rates?.count ?? 1)
        }
        self.userRate.settings.fillMode =  .precise
        self.userRate.rating = agentRate
        
    }
    
}




