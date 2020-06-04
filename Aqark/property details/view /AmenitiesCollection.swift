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
            image = UIImage(named: "Balacony")!
        case "Covered Parking":
            image = UIImage(named: "Covered Parking")!
        case "Barbecue Area":
            image = UIImage(named: "Barbecue")!
        case "Central A/C":
            image = UIImage(named: "Central")!
        case "Children's Play Area":
            image = UIImage(named: "children")!
        case "Furnished":
            image = UIImage(named: "Furnished")!
        case "Private garden":
            image = UIImage(named: "garden")!
        case "Kitchen Appliances":
            image = UIImage(named: "kitchen")!
        case "Maids Room":
            image = UIImage(named: "Maids room")!
        case "Networked":
            image = UIImage(named: "networked")!
        case "Pets Allowed":
            image = UIImage(named: "Pets")!
        case "Security":
            image = UIImage(named: "Security")!
        case "Shared Spa":
            image = UIImage(named: "shared spa")!
        case "Study":
            image = UIImage(named: "study")!
        case "Walk-in Closet":
            image = UIImage(named: "Walk")!
        default:
            image = UIImage(named: "Furnished")!
        }
        return image
    }
    
    func updateCellLayout(cell : UICollectionViewCell ){
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}

extension PropertyDetailView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == amenitiesCollection{
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
        }else{
            if let arrOfReviewsViewModel = arrOfReviewsViewModel{
                return arrOfReviewsViewModel.count
            }else{
                return 0
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == amenitiesCollection{
            let cell:AmenitiesCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "amenitiesCell", for: indexPath) as! AmenitiesCell)
            cell.amenitiesText.text = self.advertisementDetails.amenities[indexPath.row]
            cell.amenitiesIcon.image = getAmenitiesIcon(amenities: self.advertisementDetails.amenities[indexPath.row])
            return cell
        }else{
            let cell:ReviewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell)
            reviewViewModel = arrOfReviewsViewModel[indexPath.row]
            cell.reviewerUserNameLabel.text = reviewViewModel.userName
            cell.reviewContentTextView.text = reviewViewModel.reviewContent
            updateCellLayout(cell: cell)
            return cell
        }
    }
}

extension PropertyDetailView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == amenitiesCollection{
            return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/3)
        }else{
            return CGSize(width: collectionView.frame.width - 50, height: collectionView.frame.height - 10)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == reviewsCollectionView
        {
            return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        }
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}


