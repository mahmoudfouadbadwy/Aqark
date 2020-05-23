//
//  extentionForEdit.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/22/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

//MARK: - extentionEditAdvertisementViewModel

extension AddAdvertisementViewModel{
    
   
    
    func editAdvertisement(id :String , date:String)
    {
       editAdvertisementDataSource = EditAdvertisementDataSource(advertisementId: id)
        // delete image in urlimage array
//        if(urlImages.count > 0){
//            extractImageNameFromUrl(urlImags: urlImages,completion : { x in
//                editAdvertisementDataSource.deleteStorgeImage(urlImages : x)
//            })
//        }
        //upload images if in seleted images have data
        if(dataImages.count > 0){
            // we will have complition her to change image data to string
        }
        //updata data
        let amins = Array(aminities.values)
        let addAdvertisementModel = AddAdvertisementModel(propertyType: propertyType,
                                                          advertisementType: advertisementType,
                                                          price: price,
                                                          bedrooms: bedrooms,
                                                          bathroom: bathroom,
                                                          size: size,
                                                          phone: phone,
                                                          location: location,
                                                          latitude: latitude,
                                                          longitude: longitude,
                                                          country: country,
                                                          description: description,
                                                          aminities: amins ,
                                                          date: date,
                                                          images: dataImages,
                                                          payment: payment)
        
        
        editAdvertisementDataSource.updateAdvertisement(advertisement : addAdvertisementModel )
        
    }
    
    func extractImageNameFromUrl(urlImags : [String] , completion: ([String])->())
    {
        var allImages:[String] = [String]()
        for i in urlImags{
            let parts = i.components(separatedBy: "%2F")
            let x = parts[1].components(separatedBy: "?")
            allImages.append(x[0])
        }
        
        completion(allImages)
    }
    
    
}
