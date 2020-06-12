//
//  SearchViewModel.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import ReachabilitySwift

class AdvertisementListViewModel{
    
    var advertismentsViewModel : [AdvertisementViewModel] = [AdvertisementViewModel]()
    private var dataAccess : AdvertisementData
    init(dataAccess : AdvertisementData ) {
        self.dataAccess = dataAccess
    }
    
    func populateAds(completionForPopulateAds : @escaping (_ adsResults:[AdvertisementViewModel]) -> Void){
        AdvertisementData().getAllAdvertisements(){(searchResults) in
            self.advertismentsViewModel.removeAll()
        self.advertismentsViewModel = searchResults.map{ ad in
            AdvertisementViewModel(model: ad)
        }
        completionForPopulateAds(self.advertismentsViewModel)
    }
    }
}

class AdvertisementViewModel{
    var image: String!
    var propertyType: String!
    var price: Double!
    var address: String!
    var country: String!
    var size: String!
    var longtiude : Double!
    var latitude : Double!
    var bedRoomsNumber: String!
    var bathRoomsNumber: String!
    var advertisementId : String!
    var advertisementType : String!
    var advertisementDate : String!

    init(model : AdvertisementSearchModel){
        self.image = model.image
        self.propertyType = model.propertyType
        self.price = model.price
        self.address = model.address
        self.country = model.country
        self.size = model.size
        self.bedRoomsNumber = model.bedRoomsNumber
        self.bathRoomsNumber = model.bathRoomsNumber
        self.advertisementId = model.advertisementId
        self.advertisementType = model.advertisementType
        self.advertisementDate = model.date
        self.latitude = Double(model.latitude)
        self.longtiude = Double(model.longtiude)
            }
}
class MapViewModel: NSObject, MKAnnotation{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
 init(model : Map) {
    self.title = model.title
    self.coordinate = model.coordinate
    self.subtitle = model.subtitle
    }
}

struct SearchNetworking{
    static func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}


