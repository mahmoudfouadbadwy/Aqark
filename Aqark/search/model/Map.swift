//
//  Map.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/25/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Map: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
    let subtitle: String?

  init(
    title: String?,
    coordinate: CLLocationCoordinate2D,
    subtitle: String?)
  {
    self.title = title
    self.coordinate = coordinate
    self.subtitle = subtitle

  }
    
}


