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
    
    func fetchAdvertisement(completion : @escaping (EditAdvertisementModel)->()){
        editAdvertisementDataSource.fetchAdvertisement { (advertisement) in
           completion(advertisement)
        }
    }
    
    func editAdvertisement(id :String)
    {
        
       editAdvertisementDataSource = EditAdvertisementDataSource(advertisementId: id)
        // delete image in urlimage array
        if let imageWillDelete = deletedImage{
            if(imageWillDelete.count > 0){
                extractImageNameFromUrl(urlImags: imageWillDelete,completion : { x in
                    editAdvertisementDataSource.deleteStorgeImage(urlImages : x)
                })
            }
        }
        
        //upload images if in seleted images have data
        if let dataImages = dataImages
        {
            if(dataImages.count > 0)
            {
                editAdvertisementDataSource.dataImages = dataImages
            }
        }
        
        if let imageurl = urlImages
        {
            if imageurl.count > 0
            {
                editAdvertisementDataSource.urlImages = imageurl
            }
        }
        
        uploadNow()
    }
    
    func uploadNow(){
        let amins = Array(aminities.values)
        let address = ["location": location,
                       "latitude": latitude,
                       "longitude": longitude]
        
        let editAdvertisementModel = EditAdvertisementModel(phone: phone,
                                                            bathRooms: bathroom,
                                                            country: country,
                                                            bedRooms: bedrooms,
                                                            AdvertisementType: advertisementType,
                                                            description: description,
                                                            price: price,
                                                            payment: payment,
                                                            propertyType: propertyType,
                                                            images: urlImages,
                                                            Address: address as? [String : String],
                                                            size: size,
                                                            UserId: nil,
                                                            amenities: amins)
        
        if (dataImages!.count > 0){
            editAdvertisementDataSource.uploadeImageToStorage(advertisement: editAdvertisementModel)
        }else{
            editAdvertisementDataSource.updateAdvertisement(advertisement : editAdvertisementModel)
        }
        
        
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
