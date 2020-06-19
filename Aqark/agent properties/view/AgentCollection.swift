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
         agentDataAccess = AgentDataAccess()
         advertisementViewModel =
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
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(rgb: 0x1d3557).cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    private func setCellData(cell:AgentAdvertisementCell,indexPath:IndexPath)
    {
        advertisement = listOfAdvertisements[indexPath.row]
        cell.propertyType.text = advertisement.propertyType.localize
        if advertisement.advertisementType.lowercased().elementsEqual("rent")
        {
            cell.propertyPrice.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(advertisement.price))).1 + "EGP".localize
        }else
        {

            cell.propertyPrice.text = self.convertNumbers(lang:"lang".localize , stringNumber: String(Int(advertisement.price))).1 + "EGP/month".localize
        }
        
        cell.propertySize.text = self.convertNumbers(lang: "lang".localize, stringNumber: advertisement.size).1 + "sqm".localize
        cell.propertyAddress.text = advertisement.address
        cell.bedNumber.text =  self.convertNumbers(lang: "lang".localize, stringNumber: advertisement.bedroom).1
        cell.bathRoomNumber.text = self.convertNumbers(lang: "lang".localize, stringNumber: advertisement.bathroom).1 
        cell.propertyImage.sd_setImage(with: URL(string: advertisement.image), placeholderImage: UIImage(named: "NoImage"))
        if "lang".localize.elementsEqual("en"){
            cell.paymentType.text = advertisement.payment.localize.capitalized
        }else{
            cell.paymentType.text = advertisement.payment.localize
        }
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
        
        return CGSize(width: collectionView.frame.width - 20, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}


