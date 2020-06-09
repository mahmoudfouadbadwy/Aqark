//
//  extensionviewPicker.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import  UIKit

extension AddAdvertisementViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewPropertyType.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerViewPropertyType[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        propertyType = pickerViewPropertyType[row]
        updatePlaceholderForPriceTextFeild()
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerViewPropertyType[row].localize, attributes: [NSAttributedString.Key.foregroundColor:UIColor(rgb: 0x457b9d)])
    }
    
    
}

