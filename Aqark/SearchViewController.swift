//
//  SearchViewController.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    var collectionViewFlowLayout:UICollectionViewFlowLayout!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    let data: [SearchModel] = [
                                SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"),
                               SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"),
                               SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"),
                               SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2"),
                               SearchModel(image: UIImage(named: "apartment")! ,propertyType: "Apartment",price: "100,000", address: "WestTown,Sheikh Zayed, Compund, Giza", country: "Cairo", size: "300", bedRoomsNumber: "3", bathRoomsNumber: "2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionView.register(UINib(nibName: "AdvertisementCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        updateFlowLayout()
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AdvertisementCellCollectionViewCell
        cell.configure(with: data[indexPath.row])
      
        
        
        
        return cell
    }
  
    func updateFlowLayout()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemPerRow :CGFloat = 1
            let minimunLineSpacing :CGFloat = 0
            let minimunInteritemSpacing :CGFloat = 0
            
            let width = (searchCollectionView.frame.width / numberOfItemPerRow)
            let height = (searchCollectionView.frame.height/3)
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.minimumLineSpacing = minimunLineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = minimunInteritemSpacing
            searchCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
////////////search autocomplete//////////
    
    @IBAction func searchTextFieldTapped(_ sender: Any) {
        searchTextField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self as! GMSAutocompleteViewControllerDelegate
        present(acController, animated: true, completion: nil)
    }
}
    
    extension SearchViewController: GMSAutocompleteViewControllerDelegate {
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            // Get the place name from 'GMSAutocompleteViewController'
            // Then display the name in textField
            searchTextField.text = place.name
            // Dismiss the GMSAutocompleteViewController when something is selected
            dismiss(animated: true, completion: nil)
        }
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            // Handle the error
            print("Error: ", error.localizedDescription)
        }
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            // Dismiss when the user canceled the action
            dismiss(animated: true, completion: nil)
        }

}
