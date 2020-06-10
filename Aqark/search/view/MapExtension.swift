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
        self.actionButton.buttonColor = UIColor(rgb: 0x1d3557)
        actionButton.addItem(title: "Map", image: UIImage(named: "map")?.withRenderingMode(.alwaysTemplate)) { item in
            if self.isMapHidden{
                self.mapView.isHidden = false
                self.isMapHidden = false
                self.actionButton.imageView.image("search")
            }else{
                self.mapView.isHidden = true
                self.isMapHidden = true
                self.actionButton.imageView.image("map")
            }
        }
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        searchBar.text = view.annotation?.title ?? ""
        searchBarText = searchBar.text
        mapView.isHidden = true
        actionButton.imageView.image("map")
    }
    
   
    
    func putLocationOnMap(){
        for item in self.arrOfAdViewModel{
            self.longitude = item.longtiude
            self.latitude = item.latitude
            self.addressForMap = String(item.address)
            self.numberOfPropertiesInLocation = self.counts[self.addressForMap]
            let map = MapViewModel(model: Map(title: addressForMap, coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), subtitle: String(self.numberOfPropertiesInLocation)))
        maps.append(map)
        mapView.addAnnotations(maps)
        }
        counts.removeAll()
    }
    
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func limitRegion(){
        let egyptCenter = CLLocation(latitude: 29.8205528, longitude: 30.8024979)
        let region = MKCoordinateRegion(
            center: egyptCenter.coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 1000000)
        mapView.setRegion(region, animated: false)
    }
    
    

}

