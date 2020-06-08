//
//  extensionSetupView.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/27/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import  UIKit

extension AddAdvertisementViewController{
    

     func setupView(){
         //collectionView
         collectionView.delegate = self
         collectionView.dataSource = self
         registerCellOfCollectionView()
         collectionView.register(UINib(nibName: "AddAdvertisementsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "idAddAdvertisementsCollectionViewCell")
        
        priceTxtField.delegate = self
        sizeTxtField.delegate = self
        addressTxtField.delegate = self
        phoneTxtField.delegate = self
        BedroomsTxtField.delegate = self
        BathroomTxtField.delegate = self
        countyTxtField.delegate = self
        //describtionTxtView.delegate = self
        self.makeTappedGesture()
         
         //autocomplete delegation
         autocompletecontroller.delegate = self
         
         //stack view
         countryView.isHidden = true
         let screenSize: CGRect = UIScreen.main.bounds
         countryView.heightConstraint?.constant = screenSize.height;
         
         
         // picker view
         pickerViewPropertyType = ["Apartment" , "Villa" ,  "Room" ]
         pickerView.delegate = self
         pickerView.dataSource = self
         
         
         // add tapgestrure Regoginzer to imageview
         imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(choosePhotos)))
         imageView.isUserInteractionEnabled = true
         
         // configtation of YPOmagePicker
         configtationYPOmagePicker()
         
         // setup image in letf textfield
         setupImageInLeftTextField()
         
         // setup button
         saveAndEditButton.layer.cornerRadius = 20
         
         //setup textview
         describtionTxtView.layer.borderWidth = 1
         describtionTxtView.layer.borderColor = UIColor.red.cgColor
         describtionTxtView.layer.cornerRadius = 12
         
     }
     
    
}

extension AddAdvertisementViewController{
    func makeTappedGesture()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.makeDissmissKeyboard))
        self.myView.isUserInteractionEnabled = true
        self.myView.addGestureRecognizer(tap)
    }
    @objc func makeDissmissKeyboard(){
        myView.endEditing(true)
    }

}

