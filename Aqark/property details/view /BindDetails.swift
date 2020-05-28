//
//  BindDtails.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/24/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

extension PropertyDetailView{
    func bindAdvertisementData(){
        self.getImages(images: self.advertisementDetails.images, completion:self.setSliderImages)
        self.dateOfAdvertisement.text = self.advertisementDetails.date
        self.setPrice()
        self.setSpecification()
        self.address.text = self.advertisementDetails.location
        self.propertyType.text = self.advertisementDetails.propertyType
        self.propertySize.text = self.advertisementDetails.propertysize
        self.bedrooms.text = self.advertisementDetails.bedroom
        self.bathrooms.text = self.advertisementDetails.bathroom
        self.configureCallingButton()
        self.setUpAmenitiesCollection()
        self.username.text = self.agent.username
        self.company.text = self.agent.company
        self.userRate.rating = self.agent.rate
        self.advertisementDescription.text = self.advertisementDetails.description
    }
    
    
    private func setPrice()
    {
        if self.advertisementDetails.advertismentType.elementsEqual("Rent")
        {
            self.price.text = "\(self.advertisementDetails.price ?? 0.0) EGP/month"
        }
        else
        {
            self.price.text = "\(self.advertisementDetails.price ?? 0.0) EGP"
        }
    }
    
    private func setSpecification()
    {
        self.specification.text = "\(self.advertisementDetails.propertyType ?? "") for \(self.advertisementDetails.advertismentType ?? "") in \(self.advertisementDetails.country ?? "")"
    }
    
}




