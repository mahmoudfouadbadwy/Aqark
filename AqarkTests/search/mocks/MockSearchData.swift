////
////  Mocks.swift
////  AqarkTests
////
////  Created by Shorouk Mohamed on 6/16/20.
////  Copyright © 2020 ITI. All rights reserved.
////
//
//import XCTest
//import Foundation
//@testable import Aqark
//
//class MockSearchData: XCTestCase {
//        var advertisementsArray : [[String : Any]]
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    let advertisement1 : [String : Any] = ["112233":
//        ["Address":["latitude":"31.76","longitude":"33.11","location":"Mansoura"],
//         "Advertisement Type":"Rent",
//         "UserId":"123",
//         "amenities":[""],
//         "bathRooms":"1",
//         "bedRooms":"1",
//         "country":"Mansoura",
//         "date":"2020",
//         "description":"Nice",
//         "images":[""],
//         "payment":"free",
//         "phone":"111",
//         "price":"150",
//         "propertyType":"Room",
//         "size":"100"]]
//    
//    let advertisement2 : [String : Any] = ["445566":
//        ["Address":["latitude":"40.40","longitude":"35.35","location":"Cairo"],
//         "Advertisement Type":"Buy",
//         "UserId":"456",
//         "amenities":[""],
//         "bathRooms":"2",
//         "bedRooms":"2",
//         "country":"Cairo",
//         "date":"2020",
//         "description":"Beautiful",
//         "images":[""],
//         "payment":"free",
//         "phone":"222",
//         "price":"150",
//         "propertyType":"Apartment",
//         "size":"20000"]]
//    
//    
//    override init() {
//        advertisementsArray = [advertisement1,advertisement2]
//    }
//    
//    func getAdvertisements(completionForGetAdvertisements:@escaping(_ advertisementsData : [AdvertisementSearchModel]) -> Void){
//        var advertisements = [AdminAdvertisement]()
//        for child in advertisementsArray{
//            advertisements.append(self.createAdvertisement(child: child))
//        }
//        completionForGetAdvertisements(advertisements)
//    }
//    
//    private func createAdvertisement(child:[String:Any]) -> AdvertisementSearchModel{
//       func createAdvertisementSearchModel(dict : [String : Any]?, key : String)-> AdvertisementSearchModel{
//             let images = dict!["images"] as? [Any]
//             self.advertisementImage = images?[0] as? String ?? "NoImage"
//             self.advertisementPropertyType = dict?["propertyType"] as? String ?? "Not Applied"
//             self.advertisementType = dict?["Advertisement Type"] as? String ?? "Not Applied"
//             self.advertisementCountry = dict?["country"] as? String ?? "Not Applied"
//             self.advertisementId = key
//             self.advertisementPropertySize = dict?["size"] as? String ?? "Not Applied"
//             self.advertisementDate = dict?["date"] as? String ?? "Not Applied"
//             self.advertisementBedRoomsNum = dict?["bedRooms"] as? String ?? "Not Applied"
//             self.advertisementBathRoomsNum = dict?["bathRooms"] as? String ?? "Not Applied"
//             self.advertisementPropertyPrice = Localization.convertNumbers(lang: "lang".localize, stringNumber: (dict?["price"] as? String) ?? "0").0.stringValue
//             if var unwrappedAddressDict = dict?["Address"] {
//                 unwrappedAddressDict = dict?["Address"] as! [String : String]
//                 self.addressDictionary = unwrappedAddressDict as! [String : String]
//                 self.advertisementPropertyLocation = self.addressDictionary["location"] ?? "Not Applied"
//                 self.advertisementPropertyLatitude = self.addressDictionary["latitude"] ?? "0.0"
//                 self.advertisementPropertyLongtiude = self.addressDictionary["longitude"] ?? "0.0"
//             }else{
//                 self.advertisementPropertyLocation = "Not Applied"
//             }
//         
//        return AdvertisementSearchModel(
//                   image: self.advertisementImage, propertyType  : self.advertisementPropertyType,
//                   advertisementType: self.advertisementType,
//                   advertisementId: self.advertisementId,
//                   price: Double(self.advertisementPropertyPrice),
//                   address: self.advertisementPropertyLocation,
//                   country: self.advertisementCountry,
//                   size: self.advertisementPropertySize,
//                   bedRoomsNumber: self.advertisementBedRoomsNum,
//                   bathRoomsNumber:  self.advertisementBathRoomsNum,
//                   date : self.advertisementDate,
//                    longtiude: Double(self.advertisementPropertyLongtiude),
//                   latitude: Double(self.advertisementPropertyLatitude)
//               )
//        
//        
//    }
//    
//}
// 
