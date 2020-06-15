//
//  EditAutocomplete.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 6/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//
import GooglePlaces

extension EditProfileViewController: GMSAutocompleteViewControllerDelegate
{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        addressTxtField.text = place.formattedAddress
        companyTxtField.becomeFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        // Handle the error
        print("Error configration for autocompleteview : ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}
