//
//  AgentCollection.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import SDWebImage

extension AgentPropertiesView{
    func setupCollection()
    {
        self.advertisementsCollection.register(UINib(nibName: "AgentAdvertisementCell", bundle: nil), forCellWithReuseIdentifier: "agentCell")
        self.advertisementsCollection.dataSource = self
        self.advertisementsCollection.delegate = self
    }
    
    func bindCollectionData()
    {
        
        let advertisementViewModel:AgentAdvertisementListViewModel =
            AgentAdvertisementListViewModel(data: agentDataAccess)
        advertisementViewModel.getAllAdvertisements(agentId:agentId,completion: {[weak self]
            (advertisements) in
            self?.stopActivityIndicator()
            self?.listOfAdvertisements = advertisements
        })
    }
    private func setCellConfiguration(cell:UICollectionViewCell)
    {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    private func setCellData(cell:AgentAdvertisementCell,indexPath:IndexPath)
    {
        let advertisement:AgentAdvertisementViewModel = listOfAdvertisements[indexPath.row]
        cell.propertyType.text = advertisement.propertyType
        if advertisement.advertisementType.lowercased().elementsEqual("rent")
        {
            cell.propertyPrice.text = "\(advertisement.price ?? 0.0) EGP/month"
        }else
        {
            cell.propertyPrice.text = "\(advertisement.price ?? 0.0) EGP"
        }
        
        cell.propertySize.text = "\(advertisement.size ?? "") sqm"
        cell.propertyAddress.text = advertisement.address
        cell.bedNumber.text = advertisement.bedroom
        cell.bathRoomNumber.text = advertisement.bathroom
        cell.propertyImage.sd_setImage(with: URL(string: advertisement.image), placeholderImage: UIImage(named: "NoImage"))
        cell.paymentType.text = advertisement.payment.capitalized
    }
}



extension AgentPropertiesView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfAdvertisements.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AgentAdvertisementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "agentCell", for: indexPath) as! AgentAdvertisementCell
        setCellData(cell: cell, indexPath: indexPath)
        setCellConfiguration(cell: cell)
        return cell
    }
}

extension AgentPropertiesView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let details = PropertyDetailView()
        details.advertisementId = listOfAdvertisements[indexPath.row] .advertisementId
        self.navigationController?.pushViewController(details, animated: true)
        
    }
}


extension AgentPropertiesView:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 40, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}


