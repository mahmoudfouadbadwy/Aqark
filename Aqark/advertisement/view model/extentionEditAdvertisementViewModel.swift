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
        var newImages:[String] = [String]()
       editAdvertisementDataSource = EditAdvertisementDataSource(advertisementId: id)
        // delete image in urlimage array
        if let imageWillDelete = deletedImage{
            if(imageWillDelete.count > 0){
                extractImageNameFromUrl(urlImags: imageWillDelete,completion : { x in
                    editAdvertisementDataSource.deleteStorgeImage(urlImages : x)
                })
            }
        }
         self.date = date
        //upload images if in seleted images have data
        if let dataImages = dataImages{
            if(dataImages.count > 0){
                // we will have complition her to change image data to string
                editAdvertisementDataSource.uploadeImageToStorage(dataImages : dataImages ,  compeltion: uploadNow)
            }
        }else{
            uploadNow()
        }
       
       
        
    }
    
    func uploadNow(){
        //updata data
        let amins = Array(aminities.values)
        let address = ["location": location,
                       "latitude": latitude,
                       "longitude": longitude]
        
        let editAdvertisementModel = EditAdvertisementModel(phone: phone,
                                                            bathRooms: bathroom,
                                                            country: country,
                                                            bedRooms: bedrooms,
                                                            AdvertisementType: advertisementType,
                                                            date: self.date,
                                                            description: description,
                                                            price: price,
                                                            payment: payment,
                                                            propertyType: propertyType,
                                                            images: nil,
                                                            Address: address as! [String : String],
                                                            size: size,
                                                            UserId: nil,
                                                            amenities: amins)
        
        editAdvertisementDataSource.updateAdvertisement(advertisement : editAdvertisementModel)
    }
    
    func extractImageNameFromUrl(urlImags : [String] , completion: ([String])->())
    {
        var allImagesWillDeleteit:[String] = [String]()
        for i in urlImags{
            let parts = i.components(separatedBy: "%2F")
            let x = parts[1].components(separatedBy: "?")
            allImagesWillDeleteit.append(x[0])
        }
        
        completion(allImagesWillDeleteit)
    }
    
    
}
