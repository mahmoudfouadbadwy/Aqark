//
//  AmenitiesCollection.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/25/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
extension PropertyDetailView{
    
    func setUpAmenitiesCollection(){
        self.amenitiesCollection.register(UINib(nibName: "AmenitiesCell", bundle: nil), forCellWithReuseIdentifier: "amenitiesCell")
        self.amenitiesCollection.dataSource = self
        self.amenitiesCollection.delegate = self
    }
    
    private func getAmenitiesIcon(amenities:String)-> UIImage
    {
        var image:UIImage
        switch amenities {
        case "Balcony":
            image = UIImage(named: "PropertyDetail_Balacony")!
        case "Covered Parking":
            image = UIImage(named: "PropertyDetail_Covered Parking")!
        case "Barbecue Area":
            image = UIImage(named: "PropertyDetail_Barbecue")!
        case "Central A/C":
            image = UIImage(named: "PropertyDetail_Central")!
        case "Children's Play Area":
            image = UIImage(named: "PropertyDetail_children")!
        case "Furnished":
            image = UIImage(named: "PropertyDetail_Furnished")!
        case "Private garden":
            image = UIImage(named: "PropertyDetail_garden")!
        case "Kitchen Appliances":
            image = UIImage(named: "PropertyDetail_kitchen")!
        case "Maids Room":
            image = UIImage(named: "PropertyDetail_Maids room")!
        case "Networked":
            image = UIImage(named: "PropertyDetail_networked")!
        case "Pets Allowed":
            image = UIImage(named: "PropertyDetail_Pets")!
        case "Security":
            image = UIImage(named: "PropertyDetail_Security")!
        case "Shared Spa":
            image = UIImage(named: "PropertyDetail_shared spa")!
        case "Study":
            image = UIImage(named: "PropertyDetail_study")!
        case "Walk-in Closet":
            image = UIImage(named: "PropertyDetail_Walk")!
        default:
            image = UIImage(named: "PropertyDetail_Furnished")!
        }
        return image
    }
}

extension PropertyDetailView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.advertisementDetails.amenities.count > 0
        {
            return self.advertisementDetails.amenities.count
        }
        else
        {
            amenitiesHeight.constant = 0
            amenitiesTopSpace.constant = 0
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AmenitiesCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "amenitiesCell", for: indexPath) as! AmenitiesCell)
        
        cell.amenitiesText.text = self.advertisementDetails.amenities[indexPath.row]
        cell.amenitiesIcon.image = getAmenitiesIcon(amenities: self.advertisementDetails.amenities[indexPath.row])
        return cell
    }
}

extension PropertyDetailView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/3)
    }
}


