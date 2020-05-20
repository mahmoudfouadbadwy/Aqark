//
//  extensionAutocompleteView.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

extension AddAdvertisementViewController: GMSAutocompleteViewControllerDelegate  {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       
        addressTxtField.text = place.name
        latitude = "\(place.coordinate.latitude)"
        longitude =  "\(place.coordinate.longitude)"
        phoneTxtField.becomeFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error configration for autocompleteview : ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}

