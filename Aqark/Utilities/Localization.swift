//
//  Localization.swift
//  Aqark
//
//  Created by AhmedSaeed on 6/6/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation


struct Localization {
    
    static func convertNumbers(lang: String , stringNumber : String)->(NSNumber, String){
        let formatter: NumberFormatter = NumberFormatter()
        if lang.elementsEqual("en"){
            formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        }else{
            formatter.locale = NSLocale(localeIdentifier: "AR") as Locale?
        }
        guard let number = formatter.number(from: stringNumber)else{return(0 , "")}
        guard let translatedNumber = formatter.string(from: number)else{return(0,"")}
        return(number , translatedNumber)
    }
    
}

extension String{
    var localize:String{
        return NSLocalizedString(self, comment: "")
    }
}
