//
//  MapExtension.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import MapKit
import Foundation

extension SearchViewController : MKMapViewDelegate{

    func floationgBtn(){
        self.actionButton.buttonColor = .lightGray
    actionButton.addItem(title: "item 1", image: UIImage(named: "search_map")?.withRenderingMode(.alwaysTemplate)) { item in
        if self.isMapHidden{
        self.mapView.isHidden = false
        self.isMapHidden = false
        self.actionButton.imageView.image("search_list")
        }else{
           self.mapView.isHidden = true
           self.isMapHidden = true
           self.actionButton.imageView.image("search_map")
        }
    }
    view.addSubview(actionButton)
    actionButton.translatesAutoresizingMaskIntoConstraints = false
    actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        searchBar.text = view.annotation?.subtitle ?? ""
        searchBarText = searchBar.text
        mapView.isHidden = true
        actionButton.imageView.image("search_map")
    }
    
    func putLocationOnMap(){
          for item in self.arrOfAdViewModel{
              self.longitude = item.longtiude
              self.latitude = item.latitude
              self.addressForMap = String(item.address)
              self.numberOfPropertiesInLocation = self.counts[self.addressForMap]
              let map = Map(
                  title: String(self.numberOfPropertiesInLocation) , coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude),subtitle: addressForMap)
              maps.append(map)
              mapView.addAnnotations(maps)
          }
      }
}
