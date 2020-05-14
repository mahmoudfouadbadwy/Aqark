//
//  AdvertisementData .swift
//  Aqark
//
//  Created by shorouk mohamed on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

class AdvertisementData{

    static func getAllAdvertisements() -> [SearchModel] {
        
    var data = [SearchModel]()
        
    data.append( SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "Mossadak", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"))
    data.append( SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "Mossadak", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"))
    data.append( SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"))
    data.append( SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"))
    data.append( SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"))
    data.append( SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"))
        return data
}
}
